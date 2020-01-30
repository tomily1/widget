# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicWidgetsController do
  let(:showoff_double) { double('showoff_api') }

  describe '#index' do
    before(:each) do
      allow(ShowoffApi::Widget).to receive(:new)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:fetch)
        .and_return(showoff_double)
      allow(showoff_double).to receive(:code)
        .and_return(:fail)
    end

    it 'calls #index in ShowoffApi::Widget' do
      expect(showoff_double).to receive :fetch
      get :index
      expect(response.status).to eq 200
    end
  end
end
