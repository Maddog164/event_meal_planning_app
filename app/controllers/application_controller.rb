require './config/environment'
require "./app/models/user"
require "./app/models/event"
require "./app/models/dish"
require "./app/models/event_dishes"

class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :'users/index'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
