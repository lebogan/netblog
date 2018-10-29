# ===============================================================================
#         FILE:  netblog.cr
#        USAGE:  netblog
#  DEVELOPMENT:  crystal build|run src/netblog.cr
#      RELEASE:  crystal build --release src/netblog.cr
#  DESCRIPTION:  Browser-enabled network maintenance logger written in Crystal
# REQUIREMENTS:  shards: see shard.yml
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-10 17:00
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
#    GIT REPOS:  devforge, GitHub, BitBucket
#             :  git remote add origin ssh://lewisb@devforge/var/lib/git/repos/netblog.git
#             :  git remote set-url --add --push origin ssh://devforge/var/lib/git/repos/netblog.git
#             :  git remote set-url --add --push origin git@github.com:lebogan/netblog.git
#             :  git remote set-url --add --push origin git@bitbucket.org:lebogan/netblog.git
#             :  git push -u origin master
# Distributed under terms of the MIT license.
# ===============================================================================
require "kemal"
require "kemal-session"
require "kemal-flash"
require "kilt/slang"
require "./netblog_crud.cr"
require "./netblog_helpers.cr"
require "./version.cr"

# Extras for help with troubleshooting
def show_env(*data)
  "#{data}"
end

class Object
  macro methods
   {{ @type.methods.map &.name.stringify }}
  end
end

# Configuration blocks for Kemal and Kemal::Session
Kemal.config.tap do |config|
  config.env = "development"
  config.host_binding = "0.0.0.0"
  config.port = 4567
end

Kemal::Session.config.tap do |config|
  config.secret = ENV["SESSION_SECRET"]
  config.cookie_name = "netblog_sessid"
  config.gc_interval = 2.minutes # 2 minute garbage collection
  config.engine = Kemal::Session::MemoryEngine.new
end

# Helps make code easier to read and write using a helper macro.
#
macro my_renderer(filename)
  render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
end

# General site route handlers
get "/about" do
  title = "About"
  my_renderer "about"
end

get "/license" do
  title = "License"
  my_renderer "license"
end

get "/notes" do
  title = "Notes"
  my_renderer "notes"
end

error 404 do
  title = "Oops!"
  my_renderer "error404"
end

error 500 do
  title = "Seriously?"
  my_renderer "error500"
end

# Route handlers for database operations
get "/" do |env|
  title = "NetBLog"
  my_renderer "logs"
end

get "/log/new" do
  title = "New Entry"
  my_renderer "new_memo"
end

post "/log/new" do |env|
  entry = Memo.new
  entry.entry_date = Time.now.to_s("%FT%T")
  entry.category = env.params.body["category"]
  entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
  env.flash["success"] = "Log entry successfully added!" if save_record(entry)
  env.redirect "/"
end

get "/log/:id/edit" do |env|
  title = "Edit Entry"
  entry = find_record(env.params.url["id"])
  my_renderer "edit_memo" if entry
end

post "/log/:id/edit" do |env|
  entry = find_record(env.params.url["id"])
  if entry
    entry.category = env.params.body["category"]
    entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
    env.flash["success"] = "Log entry successfully updated!" if save_record(entry)
    env.redirect "/"
  end
end

get "/maintenance" do |env|
  title = "Maintenance"
  my_renderer "maintenance"
end

post "/backup" do |env|
  if env.params.body["prune"] == "true"
    number_old_files = prune_files
    env.flash["success"] = "Backups successful. Deleted #{number_old_files} old backup files." if run_backup
  else
    env.flash["success"] = "Backups successful!" if run_backup
  end
  env.redirect "/"
end

post "/restore" do |env|
  status, result = run_restore(env)
  if status == 0
    env.flash["success"] = "Restore successful!"
  else
    env.flash["warning"] = "Restore failed: #{result}"
  end
  env.redirect "/"
end

post "/integrity_check" do |env|
  status, result = integrity_check
  if status == 0 && result.chomp == "ok"
    env.flash["success"] = "All's good in the neighborhood!"
  else
    env.flash["danger"] = "Check under the hood: #{result}"
  end
  env.redirect "/"
end

get "/search" do
  title = "Search"
  my_renderer "search"
end

post "/search_by" do |env|
  title = "Search"
  case
  when env.params.body["search_by_date"] == "true"
    caption = "entry_date"
    queries = query_records("entry_date", env.params.body["entry_date"])
    my_renderer "query"
  when env.params.body["search_by_category"] == "true"
    caption = "category"
    queries = query_records("category", env.params.body["category"])
    my_renderer "query"
  when env.params.body["search_by_memo"] == "true"
    caption = "memo"
    queries = query_records("memo", env.params.body["memo"])
    my_renderer "query"
  else
    env.redirect "/search"
  end
end

get "/log/:id/delete" do |env|
  title = "Delete Entry"
  env.flash["danger"] = "Log entry is about to be deleted!!!"
  entry = find_record(env.params.url["id"])
  my_renderer "delete_memo" if entry
end

post "/log/:id/delete" do |env|
  entry = find_record(env.params.url["id"])
  delete_record(entry) if entry
  env.redirect "/"
end

Kemal.run
