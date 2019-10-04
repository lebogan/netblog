# ===============================================================================
#         FILE:  netblog.cr
#        USAGE:  netblog
#  DEVELOPMENT:  crystal build|run src/netblog.cr
#      RELEASE:  crystal build --release --warnings all src/netblog.cr
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
require "myutils"
require "socket"
require "kemal"
require "kemal-session"
require "kemal-flash"
require "kilt/slang"
require "./netblog_crud"
require "./utils"
require "./config"

module Netblog
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
    entry.entry_date = Time.local.to_s("%F %T")
    entry.category = env.params.body["category"]
    entry.memo = Myutils.punctuate!(Myutils.capitalize!(env.params.body["memo"]))
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
      entry.memo = Myutils.punctuate!(Myutils.capitalize!(env.params.body["memo"]))
      env.flash["success"] = "Log entry successfully updated!" if save_record(entry)
      env.redirect "/"
    end
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
end

Kemal.run do |config|
  server = config.server.not_nil!
  server.bind_tcp Netblog.resolve_ip(System.hostname), 9021, reuse_port: true
end
