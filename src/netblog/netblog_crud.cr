require "sqlite3"
require "granite/adapter/sqlite"

Granite.settings.logger = Logger.new(nil) # suppress debug output from amber.

# Models the entries table and preprocesses entries using callbacks.
class Memo < Granite::Base
  adapter sqlite
  before_save :upcase_category
  before_save :format_memo

  table_name entries
  field entry_date : String
  field category : String
  field memo : String

  # Converts category to upper case.
  def upcase_category
    if category = @category
      @category = category.upcase
    end
  end

  # Capitalizes the first word and inserts a period if terminating punctuation missing.
  def format_memo
    if memo = @memo
      @memo = punctuate!(capitalize!(memo))
    end
  end
end

# Retrieves all records from the database, newest first
def find_all_records
  Memo.all("ORDER BY entry_date DESC LIMIT 10")
end

# Saves/updates the row to the database.
def save_record(entry, env)
  entry.entry_date = Time.now.to_s("%FT%T")
  entry.category = env.params.body["category"]
  entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
  entry.save
end

# Find a record by id.
def find_record(id : String)
  Memo.find id
end

# Find all related records, newest first.
def query_records(column : String, value : String)
  Memo.all("WHERE #{column} LIKE ? ORDER BY entry_date DESC", ["%#{value}%"])
end

# Deletes a record.
def delete_record(entry)
  entry.destroy
end
