# ===============================================================================
#         FILE:  netblog.cr
#        USAGE:  netblog [arguments...] [options...]
#  DEVELOPMENT:  crystal build|run src/netblog.cr
#      RELEASE:  crystal build --release --no-debug src/netblog.cr
#  DESCRIPTION:  Web-based network maintenance logger written in Crystal
# REQUIREMENTS:  shards: see shard.yml
#         TODO:  ---
#         NOTE:  ---
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-10 17:00
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
#    GIT REPOS:  devforge, GitHub, BitBucket
#             :  git remote add origin ssh://devforge/var/lib/git/repos/netblog.git
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

macro my_renderer(filename)
  render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
end

Kemal.config.tap do |config|
  config.env = "development"
  config.port = 4567
  config.public_folder = "./src/public"
end

Kemal::Session.config.tap do |config|
  config.secret = "my_really_super_secret"
  config.engine = Kemal::Session::MemoryEngine.new
end

def show_env(data)
  "#{data}"
end

# General route handlers
get "/logs" do |env|
  title = "NetBLog"
  entries = find_all_records
  my_renderer "home"
end

get "/search" do |env|
  title = "Search"
  my_renderer "search"
end

get "/backup" do |env|
  title = "Backup"
  my_renderer "backup"
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

post "/log" do |env|
  entry = Memo.new
  env.flash["success"] = "Entry successfully added" if save_record(entry, env)
  show_env(env.flash)
  #env.redirect "/logs"
end

put "/log/:id" do |env|
  entry = find_record(env.params.url["id"])
  if entry
    #entry.category = env.params.body["category"]
    #entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
    save_record(entry, env)
    env.redirect "/logs"
  end
end

get "/log/:id/delete" do |env|
  title = "Delete"
  entry = find_record(env.params.url["id"])
  my_renderer "delete_memo" if entry
end

delete "/log/:id" do |env|
  entry = find_record(env.params.url["id"])
  delete_record(entry) if entry
  env.redirect "/logs"
end

Kemal.run
