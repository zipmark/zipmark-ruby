module Zipmark
  module Adapters
    class HTTPClientAdapter
      begin
        require 'httpclient'
      rescue LoadError
        puts 'You must install httpclient to use Zipmark::Adapters::HTTPClientAdapter '
      end

      attr_accessor :username, :password, :production

      def httpclient
        @httpclient ||= initialize_client
      end

      def initialize_client
        client = HTTPClient.new(
          default_header: { 'Content-Type' => 'application/json', 'Accept' => api_accept_mime },
          force_basic_auth: true
        )
        client.ssl_config.ssl_version = :TLSv1
        client.set_auth(api_endpoint, username, password)
        return client
      end

      def api_endpoint
        production ? PRODUCTION_API_ENDPOINT : SANDBOX_API_ENDPOINT
      end

      def api_accept_mime
        "application/vnd.com.zipmark.#{API_VERSION}+json"
      end

      def get(path)
        httpclient.get(url_for(path))
      end

      def post(path, body)
        httpclient.post(url_for(path), :body => body.to_json)
      end

      def put(path, body)
        httpclient.put(url_for(path), :body => body.to_json)
      end

      def delete(path)
        httpclient.delete(url_for(path))
      end

      def url_for(path)
        path = URI.parse(path)
        if path.kind_of? URI::Generic
          path = URI.parse(api_endpoint) + path
        end
      end

      def successful?(response)
        response.code >= 200 && response.code < 300
      end

      def validation_error?(response)
        response.code == 422
      end
    end
  end
end
