require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end
  
  post "/signup" do
    user = User.new(:name => params[:name], :password => params[:password])
    binding.pry
		if user.save && user[:name]!=""
			redirect "/login"
		else
			redirect "/failure"
		end
	end

  get '/event' do
    @user = User.find(session[:user_id])
    binding.pry
    erb :event
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by(:name => params[:name])
    binding.pry
		if @user && @user[:name]!="" && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect "/event"
		else
			redirect "/failure"
		end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
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
