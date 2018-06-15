module Netblog
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
  LICENSE = {{ `cat LICENSE`.stringify }}
end
