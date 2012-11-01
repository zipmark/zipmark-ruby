require 'zipmark/callback'
require 'zipmark/client'
require 'zipmark/collection'
require 'zipmark/entity'
require 'zipmark/error'
require 'zipmark/iterator'
require 'zipmark/pagination'
require 'zipmark/resource'
require 'zipmark/util'
require 'zipmark/version'

require 'zipmark/adapters/httpclient_adapter'

module Zipmark
  PRODUCTION_API_ENDPOINT = 'https://api.zipmark.com'
  SANDBOX_API_ENDPOINT = 'https://sandbox.zipmark.com'
  API_VERSION = 'v2'

  class ClientError < StandardError; end
  class ResourceError < StandardError; end
end
