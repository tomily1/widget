# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :widget_types

  def logged_in?
    session[:logged_in]
  end

  def widget_types
    %w[visible hidden]
  end

  def flash_message(response)
    flash[response.code] = response.message
  end

  def authenticated?
    redirect_to root_path unless logged_in?
  end

  def token
    return nil unless session[:user].present?

    session[:user]['access_token']
  end
end
