# ===============================================================================
#         FILE:  crud.cr
#        USAGE:  Internal
#  DESCRIPTION:  Defines database model and CRUD functions.
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-10 17:00
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
# ===============================================================================

require "pg"
require "granite/adapter/pg"

# Register the PostgreSQL adapter, pg.
Granite::Connections << Granite::Adapter::Pg.new(name: "pg", url: ENV["NETBLOG_DATABASE_URL"])

# Models the entries table and preprocesses entries using callbacks.
class Memo < Granite::Base
  connection pg
  before_save :upcase_category
  before_save :format_memo

  table entries
  column id : Int64, primary: true
  column entry_date : String # entry is not nilable
  column category : String?  # entry is nilable
  column memo : String?      # entry is nilable
  timestamps

  # Converts category to upper case.
  def upcase_category
    if category = @category
      @category = category.upcase
    end
  end

  # Capitalizes the first word and inserts a period if terminating punctuation missing.
  def format_memo
    if memo = @memo
      @memo = Netblog.punctuate!(Netblog.capitalize!(memo))
    end
  end
end

# Saves a row to the database.
def save_record(entry)
  entry.save
end

# Retrieves all records from the database, newest first
def find_all_records
  Memo.all("ORDER BY entry_date DESC LIMIT 10")
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
