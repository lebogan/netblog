# ===============================================================================
#         FILE:  utils.cr
#        USAGE:  Internal
#  DESCRIPTION:  Some helpers.
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2019-05-26 12:09
#    COPYRIGHT:  (C) 2019 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
# ===============================================================================

module Netblog
  # Helps make rendering views easier to read and write by including the layout
  # file.
  #
  macro my_renderer(filename)
    render "src/views/#{{{filename}}}.slang", "src/views/layouts/layout.slang"
  end

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

  def self.resolve_ip(hostname)
    resolve_hostname(hostname).to_s.gsub(":7", "")
  end

  # Builds a date string
  #
  def self.date_stamp
    time = {{ (env("SOURCE_DATE_EPOCH") || `date +%s`).to_i }}
    Time.unix(time).to_s("%Y-%m-%d")
  end

  # Truncates a _text_ string longer than _length_ characters and prints
  # a _truncate_ _string_ (defaults to '...') in place of the removed text.
  # Defaults to # 48 characters.
  #
  # ```
  # Netblog.truncate("hello, world", 10, "...") # => hello, ...
  # ```
  #
  def self.truncate(text : String, length = 48, trunc_string = "...") : String
    text.size > length ? "#{text[0...length - trunc_string.size]}#{trunc_string}" : text
  end

  # Capitalizes only the first word in a string, leaving the rest untouched. This
  # preserves the words I want capitalized intentionally.
  #
  # ```
  # Netblog.capitalize!("my dog has Fleas") # => "My dog has Fleas"
  # ```
  def self.capitalize!(string : String) : String
    String.build { |str| str << string[0].upcase << string[1..string.size] }
  end

  # Adds a period to the end of a string if no terminating punctuation (?, !, .)
  # is present.
  #
  # ```
  # Netblog.punctuate!("let's end this")  # => "let's end this."
  # Netblog.punctuate!("let's end this!") # => "let's end this!"
  # Netblog.punctuate!("let's end this?") # => "let's end this?"
  # ```
  def self.punctuate!(string : String) : String
    case string
    when .ends_with?('.'), .ends_with?('?'), .ends_with?('!')
      string
    else
      string.insert(-1, '.')
    end
  end
end
