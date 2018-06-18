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
require "kilt/slang"
require "./netblog/*"

macro my_renderer(filename)
  render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
end

public_folder "./src/public"

# General route handlers
get "/" do |env|
  title = "NetBLog"
  memos = find_all_records
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
get "/new" do |env|
  "Creates new memo"
  title = "New"
  entry = Memo.new
  my_renderer "new_memo"
end

get "/memo/:id" do |env|
  "Shows memo"
end

get "/memo/:id/edit" do |env|
  "Edits memo"
end

post "/memo" do |env|
  "Saves memo"
  entry = Memo.new
  entry.entry_date = Time.now.to_s("%FT%T")
  entry.category = env.params.body["category"]
  entry.memo = punctuate!(capitalize!(env.params.body["memo"]))
  save_record(entry)
  env.redirect "/"
end

put "/memo/:id" do |env|
  "Updates memo"
end

delete "/memo/:id" do |env|
  "Deletes memo"
end

Kemal.run
