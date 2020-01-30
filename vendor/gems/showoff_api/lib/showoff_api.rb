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

  def self.make_request(method, url, args = {}, headers = {}, params = {})
    body = args.to_json
    logger = @client.logger
    host = @client.host

    http_headers = {
      content_type: :json
    }.merge(headers)

    logger.debug(http_headers) if logger&.debug?
    logger.debug(args) if logger&.debug?

    full_url = host + url

    unless params.empty?
      query = params.to_a.map do |param|
        "" + param[0].to_s +  "=" + param[1]
      end.join('&')
      full_url = full_url + '?' + query
    end

    begin
      rest_response = RestClient::Request.execute(
        method: method,
        url: full_url,
        payload: body,
        headers: http_headers
      )
    
    rescue RestClient::ExceptionWithResponse, SocketError, Errno::ECONNREFUSED => e
      logger.debug(e) if logger&.debug?
      rest_response = { code: 999, message: 'Server error', data: [] }.to_json
    end
    logger.debug(rest_response) if logger&.debug?

    JSON.parse(rest_response)
  end

  def self.auth_credential
    {
      client_id: @client.client_id,
      client_secret: @client.client_secret
    }
  end
end
