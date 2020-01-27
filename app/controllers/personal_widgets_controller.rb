class PersonalWidgetsController < ApplicationController
  before_action :authenticated?

  def index
    @kind = ["visible", "hidden"]
    result = ShowoffApi::User.new.my_widgets(token, params[:term] || '')
    @my_widgets = (result.code == :success) ? result.data['widgets'] : []
  end

  def create
    response = ShowoffApi::Widget.new.create(token, { widget: widget_params })
    if response.code == :success
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end
    redirect_to personal_widgets_path
  end

  private

  def widget_params
    params.permit(
      :name, :description, :kind
    )
  end
end
