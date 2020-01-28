# frozen_string_literal: true

module ShowoffApi
  class User
    def initialize(configuration = nil)
      @config = configuration || ::ShowoffApi.client
      @client_id = @config.client_id
      @client_secret = @config.client_secret
    end

    def my_widgets(token, term = "")
      url = '/api/v1/users/me/widgets'
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:get, url, {}, headers, fetch_params(term))

      ShowoffApi::Response.new(response)
    end

    def widgets(token, id, term = "")
      url = "/api/v1/users/#{id}/widgets"
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:get, url, {}, headers, fetch_params(term))

      ShowoffApi::Response.new(response)
    end

    def update(token, user = {})
      url = '/api/v1/users/me'
      body = { user: user }
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:put, url, body, headers)

      ShowoffApi::Response.new(response)
    end

    def show(token, id = nil)
      has_id = id.nil? ? '/me' : "/#{id}"
      url = '/api/v1/users' + has_id
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:get, url, {}, headers)

      ShowoffApi::Response.new(response)
    end

    def change_password(token, payload)
      url = '/api/v1/users/me/password'
      body = { "user": payload }
      headers = {
        Authorization: "Bearer #{token}"
      }

      response = ::ShowoffApi.make_request(:post, url, body, headers)

      ShowoffApi::Response.new(response)
    end

    def check_email(token, email)
      url = '/api/v1/users/email'
      params = {
        email: email
      }.merge(auth_credential)

      response = ::ShowoffApi.make_request(:get, url, { params: params }, {})

      ShowoffApi::Response.new(response)
    end

    def reset_password(payload)
      url = '/api/v1/users/reset_password'
      body = {
        "user": payload
      }.merge(auth_credential)

      response = ::ShowoffApi.make_request(:post, url, body, {})

      ShowoffApi::Response.new(response)
    end

    private

    def fetch_params(term = "")
      if term.empty?
        auth_credential
      else
        { term: term }.merge(auth_credential)
      end
    end

    def auth_credential
      {
        client_id: @client_id,
        client_secret: @client_secret
      }
    end
  end
end
