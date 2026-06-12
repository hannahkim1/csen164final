class SessionsController < ApplicationController
  def new
  end

  # login
  def create
    user = User.find_by(username: params[:username].to_s.strip.downcase)
    # authenticate with password
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_content
    end
  end

  # logout
  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Logged out."
  end
end
