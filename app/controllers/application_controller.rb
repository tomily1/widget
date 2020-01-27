# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?

  def logged_in?
    session[:logged_in]
  end

  def token
    return nil unless session[:user].present?
    session[:user]["access_token"]
  end
end
