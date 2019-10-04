# ===============================================================================
#         FILE:  config.cr
#        USAGE:  Internal
#  DESCRIPTION:  Kemal configuration.
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2019-10-04 10:56
#    COPYRIGHT:  (C) 2019 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
# ===============================================================================
module Netblog
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
  LICENSE = {{ `cat LICENSE`.stringify.split("\n\n") }}

  # Configuration blocks for Kemal and Kemal::Session
  def Kemal.display_startup_message(config, server)
    addresses = server.addresses.map { |address| "#{config.scheme}://#{address}" }.join ", "
    log "[#{config.env}] NetBlog is alive at #{addresses}"
  end

  Kemal.config do |config|
    config.env = "development"
  end

  if Kemal.config.env == "production"
    Kemal.config.logging = false
  end

  Kemal::Session.config.tap do |config|
    config.secret = ENV["NETBLOG_SESSION_SECRET"]
    config.cookie_name = "netblog_sessid"
    config.gc_interval = 2.minutes # 2 minute garbage collection
    config.engine = Kemal::Session::MemoryEngine.new
  end
end
