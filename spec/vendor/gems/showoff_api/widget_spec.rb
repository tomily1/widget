# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShowoffApi::Widget do
  let(:configuration) do
    ShowoffApi.configure do |cfg|
      cfg.client_id = 'abcd'
      cfg.client_secret = 'abcd'

      cfg.host = 'https://showoff.host'
      cfg.logger = Logger.new(STDOUT).tap { |l| l.level = :debug }
    end
  end

  subject(:client) do
    ShowoffApi::Widget.new(configuration)
  end

  def use_fixture(filename)
    expect(RestClient::Request).to receive(:execute)
      .and_return(File.read(File.join(File.dirname(__FILE__), 'fixtures', filename)))
  end

  describe '#fetch' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.fetch('124abc', '', true)

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.fetch('124abc', '')

      expect(result.code).to eq :fail
    end
  end

  describe '#create' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.fetch('124abc')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.fetch('124abc')

      expect(result.code).to eq :fail
    end
  end

  describe '#update' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.fetch('124abc')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.fetch('124abc', 'hello')

      expect(result.code).to eq :fail
    end
  end

  describe '#destroy' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.fetch('124abc')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.fetch('124abc')

      expect(result.code).to eq :fail
    end
  end
end
