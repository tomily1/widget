# frozen_string_literal: true

class PersonalWidgetsController < ApplicationController
  before_action :authenticated?
  before_action :fetch_widgets, only: %i[index edit]

  def index; end

  def create
    response = ShowoffApi::Widget.new.create(token, widget: widget_params)
    redirect_to_path(response)
  end

  def edit
    @widget = @my_widgets.select do |widget|
      widget['id'] == params['id'].to_i
    end.first
    redirect_to root_path unless @widget
  end

  def update
    response = ShowoffApi::Widget.new.update(token, params[:id], widget: widget_params)

    if response.code == :success
      redirect_to_path(response)
    else
      flash_message(response)
      redirect_to edit_personal_widget_path(params[:id])
    end
  end

  def destroy
    response = ShowoffApi::Widget.new.destroy(token, params[:id])
    redirect_to_path(response)
  end

  private

  def fetch_widgets
    term = if action_name == 'edit'
             ''
           else
             params[:term] || ''
           end
    result = ShowoffApi::User.new.my_widgets(token, term)
    @my_widgets = result.code == :success ? result.data['widgets'] : []
  end

  def redirect_to_path(response)
    flash_message(response)
    redirect_to personal_widgets_path
  end

  def widget_params
    params.permit(
      :name, :description, :kind
    )
  end
end
