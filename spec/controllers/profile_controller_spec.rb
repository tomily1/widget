# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfileController do
  let(:showoff_double) { double('showoff_api') }

  describe '#index' do
    before(:each) do
      allow(ShowoffApi::User).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:widgets)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:data)
      .and_return('widgets' => [])
    end
      
    context 'failure' do
      it 'calls #widgets in ShowoffApi::User and redirects' do
        allow(showoff_double).to receive(:code)
          .and_return(:fail)
        expect(showoff_double).to receive :widgets
        get :show, params: { id: 1 }
        expect(response.status).to eq 302
      end
    end

    context 'success' do
      it 'calls #widgets in ShowoffApi::User' do
        allow(showoff_double).to receive(:code)
          .and_return(:success)
        expect(showoff_double).to receive :widgets
        get :show, params: { id: 1 }
        expect(response.status).to eq 200
      end
    end
  end
end
