module Zipmark
  module Adapters
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
        self.class.post(path, adapter_options.merge(:body => body))
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
