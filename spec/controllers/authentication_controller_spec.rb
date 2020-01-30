# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController do
  let(:showoff_double) { double('showoff_api') }

  before(:each) do
    allow(ShowoffApi::User).to receive(:new)
      .and_return(showoff_double)
    allow(ShowoffApi::Auth).to receive(:new)
      .and_return(showoff_double)
    allow(showoff_double).to receive(:message)
      .and_return('success')
    allow(showoff_double).to receive(:code)
      .and_return(:success)
    allow(showoff_double).to receive(:data)
      .and_return('token' => '1234')
  end

  describe '#create' do
    before do
      allow(showoff_double).to receive(:login)
        .and_return(showoff_double)
    end

    it 'calls #login in ShowoffApi::Auth and redirects' do
      expect(showoff_double).to receive(:login)
      post :create, params: {
        username: 'test@gmail.com',
        password: 'password'
      }
      expect(response.status).to eq(302)
    end
  end

  describe '#logout' do
    before do
      allow(showoff_double).to receive(:revoke)
        .and_return(showoff_double)
    end

    it 'calls #revoke in ShowoffApi::Auth and redirects' do
      expect(showoff_double).to receive(:revoke)
      post :logout, params: { token: 'valid_token' }
      expect(response.status).to eq(302)
    end
  end

  describe '#register' do
    before do
      allow(showoff_double).to receive(:register)
        .and_return(showoff_double)
      allow(controller).to receive(:image_url)
        .and_return('Base64:image;')
    end

    it 'calls #register in ShowoffApi::Auth and redirects' do
      expect(showoff_double).to receive(:register)
      post :register, params: {
        first_name: 'first',
        last_name: 'last',
        email: 'test@test.com',
        password: 'password',
        image: 'file'
      }
      expect(response.status).to eq(302)
    end
  end

  describe '#reset_password' do
    before do
      allow(showoff_double).to receive(:reset_password)
        .and_return(showoff_double)
    end

    it 'calls #reset_password in ShowoffApi::User and redirects' do
      expect(showoff_double).to receive(:reset_password)
      post :reset_password, params: { email: 'test@test.co' }
      expect(response.status).to eq(302)
    end
  end
end
