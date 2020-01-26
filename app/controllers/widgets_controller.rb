# frozen_string_literal: true

class WidgetsController < ApplicationController
  def index
    result = ShowoffApi::Widget.new.fetch(nil, params[:term] || '', true)
    @visible_widgets = if result.code == :success
                         result.data['widgets']
                       else
                         []
                       end
  end
end
