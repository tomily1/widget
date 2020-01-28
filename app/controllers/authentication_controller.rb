class AuthenticationController < ApplicationController
  def create
    payload = {
      username: params[:username],
      password: params[:password]
    }

    response = ShowoffApi::Auth.new.login(payload)

    if response.code == :success
      token_data = response.data["token"]
      session[:user] = token_data
      session[:logged_in] = true
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end

    redirect_to root_path
  end

  def logout
    response = ShowoffApi::Auth.new.revoke(token)

    if response.code == :success
      flash[:success] = response.message
      reset_session
    else
      flash[:error] = response.message
    end

    redirect_to root_path
  end

  def register
    response = ShowoffApi::Auth.new.register(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:username],
      password: params[:password],
      image_url: image_url
    )

    if response.code == :success
      token_data = response.data["token"]
      session[:user] = token_data
      session[:logged_in] = true
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end

    redirect_to root_path
  end

  def reset_password
    response = ShowoffApi::User.new.reset_password(email: params[:email])
    if response.code == :success
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end
  
    redirect_to root_path
  end

  private

  def image_url
    file = params[:image]
    Base64.encode64(File.read(file.path))
  end
end
