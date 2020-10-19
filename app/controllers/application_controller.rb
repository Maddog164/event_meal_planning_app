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
    # binding.pry
		if @user && @user[:name]!="" && @user.authenticate(params[:password])
			session[:user_id] = @user.id
      redirect "/events/new"
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

#   get "/events" do
#     binding.pry
#     @events = Event.all
#     binding.pry
#     erb :'/events/new' 
#  end
 
 get '/events/new' do
    @events = Event.all
    @dishes = Dish.all
    binding.pry 
    erb :'/events/new'
 end

 post '/events' do
  binding.pry
  @event = Event.where(name: params[:event][:name])
  binding.pry
  redirect "events/#{@event.id}/edit"
end

get '/events/:id/edit' do 
  @event = Event.find(params[:id])
  @dishes = Dish.all
  erb :'/events/edit'
end

get '/events/:id' do 
  @event = Event.find(params[:id])
  erb :'/events/show'
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
