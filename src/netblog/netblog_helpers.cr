# ===============================================================================
#         FILE:  netblog_helpers.cr
#        USAGE:  Internal
#  DESCRIPTION:  Helpers
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-25 10:53
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
# ===============================================================================

DB_DIR = ENV["DB_DIR"]

# Capitalizes only the first word in a string, leaving the rest untouched. This
# preserves the words I want capitalized intentionally.
#
# ```
# capitalize!("my dog has Fleas") # => "My dog has Fleas"
# ```
def capitalize!(string : String) : String
  string[0].to_s.upcase + string[1..string.size]
end

# Returns a timestamped _filename_ as a Tuple(String) with no path element.
#
# ```
# timestamp_filename(test.log) # => {"test_mm-dd-yyyy-hhmm.log"}
# ```
#
# Access the string with:
# ```text
# {"test_mm-dd-yyyy-hhmm.log"}[0] # => test_mm-dd-yyyy-hhmm.log
# ```
#
def timestamp_filename(filename : String) : Tuple(String)
  {File.join({"#{File.basename(filename, File.extname(filename))}_" \
              "#{Time.now.to_s("%m-%d-%Y-%H%M")}#{File.extname(filename)}"})}
end

# Adds a period to the end of a string if no terminating punctuation (?, !, .)
# is present.
#
# ```
# punctuate!("let's end this")  # => "let's end this."
# punctuate!("let's end this!") # => "let's end this!"
# punctuate!("let's end this?") # => "let's end this?"
# ```
def punctuate!(string : String) : String
  case string
  when .ends_with?('.') then string
  when .ends_with?('?') then string
  when .ends_with?('!') then string
  else                       string.insert(-1, '.')
  end
end

# Returns an array of files of _filetype_ older than _age_ months.
#
# ```text
# Example:
# Find all *.c files older than 90 days (3 months)
# ```
#
# ```
# find_old_files("./src", ["*.c"], 3) # => Array(String)
# ```
#
def find_old_files(path : String, filetypes : Array(String), age : Int32) : Array(String)
  old_files = [] of String
  age_in_months = Time.now - Time::MonthSpan.new(age)
  filetypes.each do |filetype|
    Dir.glob("#{path}/*.#{filetype}").each do |file|
      if File.info(file).modification_time < age_in_months
        old_files << file
      end
    end
  end
  old_files
end

# Deletes backup files older than 3 months from DB_DIR. Uses find_old_files method
# to retrieve a list of those files.
#
def prune_files
  filetypes = ["bak", "sql"]
  age = 3
  old_files = find_old_files(DB_DIR, filetypes, age)
  if old_files.empty?
    0
  else
    old_files.each { |file| File.delete(file) }
    puts "Deleted #{old_files.size} old backup files!"
    old_files.size
  end
end

# Dumps the database in .sql format and does a binary backup. Uses the SQLite3
# binary.
#
def run_backup
  db = "#{DB_DIR}/netlog.db"
  dump_filename = "#{DB_DIR}/#{timestamp_filename("netlog_db.sql")[0]}"
  bak_filename = "#{DB_DIR}/#{timestamp_filename("netlog_db.bak")[0]}"
  run_cmd("sqlite3", {"#{db}", ".output #{dump_filename}", ".dump entries"})
  run_cmd("sqlite3", {"#{db}", ".timeout 20000", ".backup #{bak_filename}"})
end

# Restores the database by reading a .sql or binary restore using .bak file.
# Will show failure using .sql file if the table already exists, but restores anyway. 
#
def run_restore(env)
  db = "#{DB_DIR}/netlog.db"
  restore_file = "#{DB_DIR}/#{env.params.body["restore_file"]}"
  unless File.file?(File.expand_path(restore_file))
    return {1, ""}
  end
  if File.extname(restore_file) == ".sql"
    run_cmd("sqlite3", {"#{db}", ".read #{restore_file}"})
  else
    run_cmd("sqlite3", {"#{db}", ".restore #{restore_file}"})
  end
end

# Checks the integrity of indexes, structure, and for corruption.
#
def integrity_check
  db = "#{DB_DIR}/netlog.db"
  run_cmd("sqlite3", {"#{db}", "Pragma integrity_check;"})
end

# Runs a system-level command and returns a Tuple(Int32, String) containing
# status, and command output or error. Args default to "".
#
# ```
# status, result = run_cmd("ls", {"-ls"}) # => 0, listing string
# ```
#
def run_cmd(cmd : String, args : Tuple = {""}) : Tuple(Int32, String)
  stdout_str = IO::Memory.new # => Stdio = Redirect::Close
  stderr_str = IO::Memory.new # ditto
  status = Process.run(cmd, args: args, output: stdout_str, error: stderr_str)
  if status.success?
    {status.exit_code, stdout_str.to_s}
  else
    {status.exit_code, stderr_str.to_s}
  end
end
