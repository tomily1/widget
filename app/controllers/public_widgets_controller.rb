# frozen_string_literal: true

class PublicWidgetsController < ApplicationController
  def index
    result = ShowoffApi::Widget.new.fetch(token, params[:term] || '', true)
    @visible_widgets = result.code == :success ? result.data['widgets'] : []
    @visible_widgets = Kaminari.paginate_array(@visible_widgets).page(params[:page]).per(9)
  end
end
