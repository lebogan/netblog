# ===============================================================================
#         FILE:  netblog.cr
#        USAGE:  netblog
#  DEVELOPMENT:  crystal build|run src/netblog.cr
#      RELEASE:  crystal build --release src/netblog.cr
#  DESCRIPTION:  Browser-enabled network maintenance logger written in Crystal
# REQUIREMENTS:  shards: see shard.yml
#         TODO:  ---
#         NOTE:  ---
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-10 17:00
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
#    GIT REPOS:  devforge, GitHub, BitBucket
#             :  git remote add origin ssh://lewisb@devforge/var/lib/git/repos/netblog.git
#             :  git set-url --add --push origin ssh://devforge/var/lib/git/repos/netblog.git
#             :  git set-url --add --push origin git@github.com:lebogan/netblog.git
#             :  git set-url --add --push origin git@bitbucket.org:lebogan/netblog.git
#             :  git push -u origin master
# Distributed under terms of the MIT license.
# ===============================================================================
require "kemal"
require "kemal-session"
require "kemal-flash"
require "kilt/slang"
require "./netblog/*"

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
  config.host_binding = "192.168.33.14"
  config.port = 4567
  config.public_folder = "./src/public"
end

Kemal::Session.config.tap do |config|
  config.secret = "my_really_super_secret"
  config.engine = Kemal::Session::MemoryEngine.new
end

macro my_renderer(filename)
  render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
end

# General site route handlers
get "/logs" do |env|
  title = "NetBLog"
  entries = find_all_records
  number_of_records = Memo.all.size
  my_renderer "home"
end

get "/about" do |env|
  title = "About"
  my_renderer "about"
end

get "/license" do |env|
  title = "License"
  my_renderer "license"
end

error 404 do
  title = "Oops!"
  my_renderer "error404"
end

# Route handlers for database operations
get "/log/new" do |env|
  "Creates new memo"
  title = "New"
  entry = Memo.new
  my_renderer "new_memo"
end

get "/log/:id" do |env|
  "Shows memo"
  title = "Memo"
  entry = find_record(env.params.url["id"])
  my_renderer "show_memo" if entry
end

get "/log/:id/edit" do |env|
  title = "Edit"
  entry = find_record(env.params.url["id"])
  entry = Memo.find env.params.url["id"]
  my_renderer "edit_memo" if entry
end

get "/backup" do |env|
  title = "Backup"
  my_renderer "backup"
end

post "/backup" do |env|
  if env.params.body["prune"] == "true"
    prune_files
    env.flash["success"] = "Backups successful!" if run_backup
  else
    env.flash["success"] = "Backups successful!" if run_backup
  end
  env.redirect "/logs"
end

get "/restore" do |env|
  title = "Restore"
  my_renderer "restore"
end

post "/restore" do |env|
  env.flash["success"] = "Restore successful!" if run_restore(env)
  env.redirect "/logs"
end

post "/log" do |env|
  entry = Memo.new
  env.flash["success"] = "Log entry successfully added!" if save_record(entry, env)
  env.redirect "/logs"
end

get "/search" do |env|
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

put "/log/:id" do |env|
  entry = find_record(env.params.url["id"])
  if entry
    entry.category = env.params.body["category"]
    entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
    env.flash["success"] = "Log entry successfully updated!" if save_record(entry, env)
    env.redirect "/logs"
  end
end

get "/log/:id/delete" do |env|
  title = "Delete"
  env.flash["danger"] = "Log entry is about to be deleted!!!"
  entry = find_record(env.params.url["id"])
  my_renderer "delete_memo" if entry
end

delete "/log/:id" do |env|
  entry = find_record(env.params.url["id"])
  delete_record(entry) if entry
  env.redirect "/logs"
end

Kemal.run
