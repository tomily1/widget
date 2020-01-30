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
    ShowoffApi::User.new(configuration)
  end

  def use_fixture(filename)
    expect(RestClient::Request).to receive(:execute)
      .and_return(File.read(File.join(File.dirname(__FILE__), 'fixtures', filename)))
  end

  describe '#my_widgets' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.my_widgets('124abc', '')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.my_widgets('wrong_cred', '')

      expect(result.code).to eq :fail
    end
  end

  describe '#widgets' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.widgets('124abc', 1, '')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.widgets('wrong_cred', 2, '')

      expect(result.code).to eq :fail
    end
  end

  describe '#update' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.update('124abc', {})

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.update('wrong_cred', {})

      expect(result.code).to eq :fail
    end
  end

  describe '#update' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.show('124abc')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.show('wrong_cred', 1)

      expect(result.code).to eq :fail
    end
  end

  describe '#change_password' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.change_password('124abc', {})

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.change_password('wrong_cred', {})

      expect(result.code).to eq :fail
    end
  end

  describe '#check_email' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.check_email('124abc', 'test@siji.co')

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.check_email('wrong_cred', 'siji@test.co')

      expect(result.code).to eq :fail
    end
  end

  describe '#reset_password' do
    it 'parses a successful response' do
      use_fixture('success.json')

      result = client.reset_password({})

      expect(result.code).to eq :success
    end

    it 'parses a failed response' do
      use_fixture('failure.json')

      result = client.reset_password({})

      expect(result.code).to eq :fail
    end
  end
end
