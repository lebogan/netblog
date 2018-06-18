# Capitalizes only the first word in a string, leaving the rest untouched. This
# preserves the words I want capitalized intentionally.
#
# ```
# Netlog.capitalize!("my dog has Fleas") # => "My dog has Fleas"
# ```
def capitalize!(string : String) : String
  string[0].to_s.upcase + string[1..string.size]
end

# Adds a period to the end of a string if no terminating punctuation (?, !, .)
# is present.
#
# ```
# Netlog.punctuate!("let's end this")  # => "let's end this."
# Netlog.punctuate!("let's end this!") # => "let's end this!"
# Netlog.punctuate!("let's end this?") # => "let's end this?"
# ```
def punctuate!(string : String) : String
  case string
  when .ends_with?('.') then string
  when .ends_with?('?') then string
  when .ends_with?('!') then string
  else                       string.insert(-1, '.')
  end
end
