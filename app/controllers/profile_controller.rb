# frozen_string_literal: true

class ProfileController < ApplicationController
  def show
    response = ShowoffApi::User.new.widgets(token, params[:id], params[:term] || '')
    redirect_to root_path if response.code == :fail
    @widgets = response.data['widgets']
  end
end
