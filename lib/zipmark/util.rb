module Zipmark
  class Util
    def self.stringify_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[key.to_s] = value
        options
      end
    end
  end
end
