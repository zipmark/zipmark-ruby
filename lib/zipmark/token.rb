require 'jwt'

module Zipmark
  class Token
    def self.encode(payload, application_secret)
      JWT.encode(payload, application_secret)
    end
  end
end
