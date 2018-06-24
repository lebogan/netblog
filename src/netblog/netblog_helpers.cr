# Capitalizes only the first word in a string, leaving the rest untouched. This
# preserves the words I want capitalized intentionally.
#
# ```
# Netlog.capitalize!("my dog has Fleas") # => "My dog has Fleas"
# ```
def capitalize!(string : String) : String
  string[0].to_s.upcase + string[1..string.size]
end

# Returns a timestamped _filename_ as a Tuple(String) with no path element.
#
# ```
# Utils.timestamp_filename(test.log) # => {"test_mm-dd-yyyy-hhmm.log"}
# ```
#
# Access the string with:
# ```
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
# Netlog.punctuate!("let's end this")  # => "let's end this."
# Netlog.punctuate!("let's end this!") # => "let's end this!"
# Netlog.punctuate!("let's end this?") # => "let's end this?"
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
# Utils.find_old_files("./src", ["*.c"], 3) # => Array(String)
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

# Runs a system-level command and returns a Tuple(Int32, String) containing
# status, and command output or error. Args default to "".
#
# ```
# status, result = Utils.run_cmd("ls", {"-ls"}) # => 0, listing string
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
