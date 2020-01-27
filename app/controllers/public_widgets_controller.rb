# frozen_string_literal: true

class PublicWidgetsController < ApplicationController
  def index
    result = ShowoffApi::Widget.new.fetch(nil, params[:term] || '', true)
    @visible_widgets = (result.code == :success) ? result.data['widgets'] : []
  end
end
