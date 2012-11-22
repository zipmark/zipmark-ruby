module Zipmark
  module Adapters
    # Public: The HTTParty Adapter.
    #
    # Important Note: PUT is broken in HTTParty when using Digest Auth
    class HTTPartyAdapter
      begin
        require 'httparty'
        include HTTParty
      rescue LoadError
        puts 'You must install httparty >= \'0.9.0\' to use Zipmark::Adapters::HTTPartyAdapter '
      end

      attr_accessor :username, :password, :production

      def api_endpoint
        production ? PRODUCTION_API_ENDPOINT : SANDBOX_API_ENDPOINT
      end

      def api_accept_mime
        "application/vnd.com.zipmark.#{API_VERSION}+json"
      end

      def get(path)
        self.class.get(path, adapter_options)
      end

      def post(path, body)
        self.class.post(path, adapter_options.merge(:body => body.to_json))
      end

      def put(path, body)
        self.class.put(path, adapter_options.merge(:body => body.to_json))
      end

      def delete(path)
        self.class.delete(path, adapter_options)
      end

      def successful?(response)
        response.code >= 200 && response.code < 300
      end

      def validation_error?(response)
        response.code == 422
      end

      private
      def adapter_options
        {
          :base_uri => api_endpoint,
          :digest_auth => { :username => username, :password => password },
          :headers => { 'Content-Type' => 'application/json', 'Accept' => api_accept_mime }
        }
      end
    end
  end
end
