require'base64'
require 'openssl'

# Ruby 1.8 compatibility
unless Base64.respond_to?(:strict_encode64)
  module Base64
    def strict_encode64(bin)
      [bin].pack("m0")
    end
  end
end

module Zipmark
  class Callback
    attr_accessor :request, :errors, :client

    def initialize(request, options = {})
      raise ArgumentError, "Request cannot be nil" unless request
      @request = request
      @errors = {}
      @client = options[:client]
    end

    def body
      @request.raw_post
    end

    def parsed_body
      @parsed_body ||= JSON.parse(body)
    end

    def identifier
      client.identifier if client
    end

    def application_identifier
      client.adapter.username if client
    end

    def secret
      client.adapter.password if client
    end

    def event
      parsed_body["callback"]["event"]
    end

    def object
      Zipmark::Entity.new(parsed_body["callback"]["object"].merge(:client => @client, :resource_type => object_type.downcase))
    end

    def object_type
      parsed_body["callback"]["object_type"]
    end

    def hashed_content
      Digest::MD5.hexdigest(body) if body
    end

    def date
      Time.parse(@request.headers["Date"]) if @request.headers["Date"]
    end

    def uri
      @request.fullpath
    end

    def date_within_range?
      date && date < Time.now + allowable_interval && date > Time.now - allowable_interval
    end

    def allowable_interval
      # 15 minutes
      15 * 60
    end

    def valid?
      validate_date && validate_authorization
    end

    def validate_authorization
      string_to_sign = ["POST",hashed_content,'application/json',date.rfc2822,uri,application_identifier].join("\n")
      signed_string = Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret, string_to_sign)).chomp
      valid_authorization = "ZM #{Base64.strict_encode64(identifier).chomp}:#{signed_string}"
      if authorization_header == valid_authorization
        return true
      else
        errors[:authorization] = "Signature does not match."
        return false
      end
    end

    def validate_date
      if date_within_range?
        return true
      else
        errors[:date] = "Date is not within bounds."
        return false
      end
    end

    def authorization_header
      @request.headers["Authorization"]
    end
  end
end
