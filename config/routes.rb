Rails.application.routes.draw do
  root 'homepage#index'
  get '/feeds' => 'feeds#index'

  # USERS
  post '/users' => 'users#create'
  get 'users/:username/tweets' => 'users#index_by_user'
  # SESSIONS
  post '/sessions' => 'sessions#create'
  get '/authenticated' => 'sessions#authenticated'
  delete '/sessions' => 'sessions#destroy'

  # TWEETS
  get '/tweets' => 'tweets#index'
  get '/tweets/:username' => 'tweets#index_by_user'
  post '/tweets' => 'tweets#create'
  delete '/tweets/:id' => 'tweets#destroy'

  # Redirect all other paths to index page, which will be taken over by AngularJS
  get '*path' => 'homepage#index'
end
