# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PersonalWidgetsController do
  let(:showoff_double) { double('showoff_api') }

  describe '#index' do
    before(:each) do
      allow(ShowoffApi::User).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:my_widgets)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:success)
      allow(showoff_double).to receive(:data)
        .and_return('widgets' => [])
      allow(controller).to receive(:authenticated?)
        .and_return(true)
    end

    it 'calls #my_widgets in ShowoffApi::User' do
      expect(showoff_double).to receive :my_widgets
      get :index
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    before(:each) do
      allow(ShowoffApi::Widget).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:create)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:success)
      allow(showoff_double).to receive(:data)
        .and_return('widgets' => [])
      allow(showoff_double).to receive(:message)
        .and_return('success')
      allow(controller).to receive(:authenticated?)
        .and_return(true)
    end

    it 'calls #create in ShowoffApi::Widget' do
      expect(showoff_double).to receive :create
      post :create, params: { name: 'test', description: 'test', kind: 'visible' }
      expect(response.status).to eq 302
    end
  end

  describe '#edit' do
    before(:each) do
      allow(ShowoffApi::User).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:my_widgets)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:success)
      allow(showoff_double).to receive(:data)
        .and_return('widgets' => [{ 'id' => 20, 'name' => 'test' }])
      allow(showoff_double).to receive(:message)
        .and_return('success')
      allow(controller).to receive(:authenticated?)
        .and_return(true)
    end

    it 'redirects if no widget matching the id' do
      expect(showoff_double).to receive :my_widgets
      get :edit, params: { id: 1 }
      expect(response.status).to eq 302
    end

    it 'does not redirect if widget matches the id' do
      expect(showoff_double).to receive :my_widgets
      get :edit, params: { id: 20 }
      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    before do
      allow(ShowoffApi::Widget).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:update)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:success)
      allow(showoff_double).to receive(:message)
        .and_return('success')
      allow(controller).to receive(:authenticated?)
        .and_return(true)
    end

    it 'updates the widget' do
      expect(showoff_double).to receive :update
      put :update, params: { id: 20, name: 'test' }
      expect(response.status).to eq 302
    end
  end

  describe '#destroy' do
    before do
      allow(ShowoffApi::Widget).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:destroy)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:success)
      allow(showoff_double).to receive(:message)
        .and_return('success')
      allow(controller).to receive(:authenticated?)
        .and_return(true)
    end

    it 'deletes the widget' do
      expect(showoff_double).to receive :destroy
      delete :destroy, params: { id: 20 }
      expect(response.status).to eq 302
    end
  end
end
