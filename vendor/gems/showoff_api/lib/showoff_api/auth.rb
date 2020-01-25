# frozen_string_literal: true

module ShowoffApi
  class Auth
    def initialize(configuration = nil)
      @config = configuration || ::ShowoffApi.client
      @client_id = @config.client_id
      @client_secret = @config.client_secret
    end

    def create(login)
      url = '/oauth/token'
      body = login.merge(auth_credential).merge("grant_type": "password")

      response = ::ShowoffApi.make_request(:post, url, body)

      ShowoffApi::Response.new(response)
    end

    def register(user)
      url = '/api/v1/users'
      body = auth_credential.merge(
        {
          'user': user
        }
      )

      response = ::ShowoffApi.make_request(:post, url, body)

      ShowoffApi::Response.new(response)
    end

    def revoke(token)
      url = '/oauth/revoke'
      body = { "token": token }
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:post, url, body, headers)

      ShowoffApi::Response.new(response)
    end

    def refresh(token)
      url = '/oauth/token'
      body = {
        "grant_type": "refresh_token",
        "refresh_token": token
      }.merge(auth_credential)

      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:post, url, body, headers)

      ShowoffApi::Response.new(response)
    end

    private

    def auth_credential
      {
        client_id: @client_id,
        client_secret: @client_secret
      }
    end
  end
end
