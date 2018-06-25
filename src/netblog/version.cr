#===============================================================================
#         FILE:  version.cr
#        USAGE:  Internal
#  DESCRIPTION:  Version and licensing stuff.
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-06-25 11:23
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
#===============================================================================

module Netblog
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
  LICENSE = {{ `cat LICENSE`.stringify.split("\n\n") }}
end
