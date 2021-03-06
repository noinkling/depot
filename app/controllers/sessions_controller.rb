class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def new
  end

  # "Login" action
  # Remembers logged in user by storing id in session
  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    # Playtime: if there are no users in database
    elsif User.count.zero?
      session[:user_id] = "temp"
      redirect_to new_user_url, alert: "Please create an initial admin user"
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  # "Log out" action
  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
