# frozen_string_literal: true

require 'rest-client'
require 'json'

Dir["#{File.dirname(__FILE__)}/showoff_api/**/*.rb"].each { |f| require(f) }

#top level module for showoff api client
module ShowoffApi
  def self.configure(&block)
    @client = Configuration.new(&block)
  end

  def self.client
    @client
  end

  def self.make_request(method, url, args = {}, headers = {})
    body = args.to_json
    logger = @client.logger
    endpoint = @client.endpoint

    http_headers = {
      content_type: :json
    }.merge(headers)

    logger.debug(http_headers) if logger&.debug?
    logger.debug(args) if logger&.debug?

    full_url = endpoint + url

    begin
      rest_response = RestClient::Request.execute(
        method: method,
        url: full_url,
        payload: body,
        headers: http_headers
      )
    rescue RestClient::ExceptionWithResponse => e
      logger.debug(e.response) if logger&.debug?
      rest_response = e.response
    end
    logger.debug(rest_response) if logger&.debug?

    JSON.parse(rest_response)
  end

  def self.auth_credential
    {
      client_id: @client_id,
      client_secret: @client_secret
    }
  end
end
