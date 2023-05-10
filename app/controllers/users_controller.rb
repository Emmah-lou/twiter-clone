class UsersController < ApplicationController


  
  def create
    @user = User.new(user_params)
    if @user and @user.save
      render json: {
        user: @user.as_json(only: [:username, :email])
      }, status: :created
    else
      render json: {message: "User not created"}, status: :unprocessable_entity
    end

  end
  
  def tweets
    @user = User.find_by(username: params[:username])
    if @user and @user.tweets
      render 'feeds/index'
    else
      render json: {message: "User not found"}, status: :unprocessable_entity
    end
  end

  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
