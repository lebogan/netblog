# ===============================================================================
#         FILE:  system.cr
#        USAGE:  Internal
#  DESCRIPTION:  Some socket stuff.
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2019-05-26 12:09
#    COPYRIGHT:  (C) 2019 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
# ===============================================================================

module Netblog
  # Does a lookup of a host's ip address and returns it as a Socket::IPAddress
  # object. Raises an error if the hostname doesn't exist or can't be resolved.
  # Remove the ":7" part with `gsub(":7"."")` to get just the ip address.
  #
  # ```
  # Netblog.resolve_host("example.com")                     # => ip_address:7
  # Netblog.resolve_host("example.com").to_s.gsub(":7", "") # => ip_address
  # ```
  #
  def self.resolve_hostname(host)
    addrinfo = Socket::Addrinfo.resolve(
      domain: host,
      service: "echo",
      type: Socket::Type::DGRAM,
      protocol: Socket::Protocol::UDP,
    ) # => Array(Socket::Addrinfo)

    addrinfo.first?.try(&.ip_address)
  end

  def self.resolve_ip_address
    resolve_hostname(System.hostname).to_s.gsub(":7", "")
  end

  def self.date
    time = {{ (env("SOURCE_DATE_EPOCH") || `date +%s`).to_i }}
    Time.unix(time).to_s("%Y-%m-%d")
  end
end
