class UsersController < ApplicationController
  # new user signup
  def new
    @user = User.new
  end

  # create new user totally
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.username}! Your account was created."
    else
      # if user creation fails, render the new user signup page
      render :new, status: :unprocessable_content
    end
  end

  # private method to get the user parameters
  private

  def user_params
    params.expect(user: [ :username, :password, :password_confirmation ])
  end
end
