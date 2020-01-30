# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShowoffApi::Auth do
  let(:configuration) do
    ShowoffApi.configure do |cfg|
      cfg.client_id = 'abcd'
      cfg.client_secret = 'abcd'

      cfg.host = 'https://showoff.host'
      cfg.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
    end
  end

  subject(:client) do
    ShowoffApi::Auth.new(configuration)
  end

  def use_fixture(filename)
    expect(RestClient::Request).to receive(:execute)
      .and_return(File.read(File.join(File.dirname(__FILE__), 'fixtures', filename)))
  end

  %i[login register revoke refresh].each do |method|
    describe "##{method}" do
      it 'parses a successful response' do
        use_fixture('success.json')

        result = client.public_send(method, {})

        expect(result.code).to eq :success
      end

      it 'parses a failed response' do
        use_fixture('failure.json')

        result = client.public_send(method, {})

        expect(result.code).to eq :fail
      end
    end
  end
end
