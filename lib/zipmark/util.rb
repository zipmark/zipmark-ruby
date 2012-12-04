module Zipmark
  # Public: Utility methods for the Zipmark API Client
  class Util
    # Public: Method which converts all of a hash's keys to strings
    #
    # hash - The hash whose keys you would like to convert
    #
    # Returns the converted Hash
    def self.stringify_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[key.to_s] = value
        options
      end
    end
  end
end

unless Base64.respond_to?(:strict_encode64)
  module Base64
    def strict_encode64(bin)
      [bin].pack("m0")
    end
  end
end
