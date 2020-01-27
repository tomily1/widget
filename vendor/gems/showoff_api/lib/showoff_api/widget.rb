# frozen_string_literal: true

module ShowoffApi
  class Widget
    BASE_URL = '/api/v1/widgets'

    def initialize(configuration = nil)
      @config = configuration || ::ShowoffApi.client
      @client_id = @config.client_id
      @client_secret = @config.client_secret
    end

    def fetch(token = nil, term = "", visible = false)
      url_part = visible ? '/visible' : ''
      url = BASE_URL + url_part
      headers = {}
      params = {
        term: term
      }.merge!(::ShowoffApi.auth_credential)

      headers.merge!({
        Authorization: "Bearer #{token}"
      }) if token.present?

      response = ::ShowoffApi.make_request(:get, url, {}, headers, params)

      ShowoffApi::Response.new(response)
    end

    def create(token, payload)
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:post, BASE_URL, payload, headers)

      ShowoffApi::Response.new(response)
    end

    def update(token, id, payload)
      headers = {
        Authorization: "Bearer #{token}"
      }

      url = BASE_URL + '/' + id

      response = ::ShowoffApi.make_request(:post, url, payload, headers)
    end

    def destroy(token, id)
      headers = {
        Authorization: "Bearer #{token}"
      }

      url = BASE_URL + '/' + id

      response = ::ShowoffApi.make_request(:delete, url, {}, headers)
    end
  end
end
