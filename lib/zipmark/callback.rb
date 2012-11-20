require'base64'
require 'openssl'

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
      raise "unimplemented"
    end

    def object
      raise "unimplemented"
    end

    def object_type
      raise "unimplemented"
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
      signed_string = Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret, string_to_sign))
      valid_authorization = "ZM #{Base64.strict_encode64(identifier)}:#{signed_string}"
      if authorization_header == valid_authorization
        return true
      else
        @errors[:authorization] = "Signature does not match."
        return false
      end
    end

    def validate_date
      if date_within_range?
        return true
      else
        @errors[:date] = "Date is not within bounds."
        return false
      end
    end

    def authorization_header
      @request.headers["Authorization"]
    end
  end
end
