class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(id: :desc)
    render 'tweets/index'
  end
  def index_by_user
    # token = cookies.permanent.signed[:twitter_session_token]
    # session = Session.find_by(token: token)
    user = User.find_by(username: params[:username])
    @tweets = user.tweets.all.order(id: :desc)
    render 'tweets/index'
    #if session
    #else
     # render json: { message: 'test'}
    #end
  end
  
  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)
      # @tweet.user_id = user.id
      if @tweet.save 
        render 'tweets/create'
      else
        render json: {message: "Tweet not created"}, status: :unprocessable_entity
      end
    else
      render json: {message: "User not found"}, status: :unprocessable_entity
    end
  end
  
  def destroy
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    @tweet = Tweet.find_by(id: params[:id])
    if session and @tweet.destroy
      render json: {success: true}
    else
      render json: {success: false}
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
