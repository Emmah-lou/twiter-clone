class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    render 'feeds/index'
  end
  def index_by_user
    @session = get_session
    if session
      user = User.find_by(username: params[:username])
      @tweets = user.tweets.all
      
      render 'feeds/index'
    else
      render json: {message: "User not found"}, status: :unprocessable_entity
    end
  end
  
  def create
    @session = get_session
    if @session
      user = @session.user
      @tweet = user.tweets.new(tweet_params)
      @tweet.user_id = user.id
      if @tweet.save 
        render 'feeds/index'
      else
        render json: {message: "Tweet not created"}, status: :unprocessable_entity
      end
    else
      render json: {message: "User not found"}, status: :unprocessable_entity
    end
  end
  
  def destroy
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet&.destroy
      render json: {message: "Tweet deleted"}
    else
      render json: {message: "Tweet not deleted"}, status: :unprocessable_entity
    end
  end

  
  private
  
  def get_session
    token = cookies.permanent.signed[:twitter_session_token]
    Session.find_by(token: token)
  end
  

  def tweet_params
    params.require(:tweet).permit(:message)
  end

end
