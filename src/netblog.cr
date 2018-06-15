#===============================================================================
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
#===============================================================================

require "./netblog/*"
require "kemal"
require "kilt/slang"

macro my_renderer(filename)
  render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
end

public_folder "./src/public"

get "/" do |env|
  title = "NetBLog"
  my_renderer "home"
end

get "/search" do |env|
  title = "Search"
  my_renderer "search"
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
Kemal.run
