class PersonalWidgetsController < ApplicationController
  def index
    result = ShowoffApi::User.new.my_widgets(token, params[:term] || '')
    @my_widgets = (result.code == :success) ? result.data['widgets'] : []
  end
  
  def new
  end
  
  def create
  end
end
