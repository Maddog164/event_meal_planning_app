require './config/environment'
require "./app/models/event"

class EventsController < ApplicationController

    configure do
        set :public_folder, 'public'
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
    end

    get '/events' do
       @events = Event.all
       binding.pry
       erb :'/events/index' 
    end
    
    get '/events/new' do
        # binding.pry
        @user = User.find(session[:user_id])
        @events = Event.where(user_id: "#{session[:user_id]}")
        @dishes = Dish.all
        @new_event_name = ""
        @new_event_date = ""
        # @events = Event.all
        # @dishes = Dish.all
        # binding.pry 
        erb :'/events/new'
    end

    get '/events/new2' do
      # binding.pry
      erb :'/events/new2'
    end
    
     post '/events' do
      # binding.pry
      hold_name = params[:"@new_event_name"]
      hold_date = params[:"@new_event_date"]
      if !Event.exists?(name: [hold_name])
        @event = Event.new(:name=>hold_name,:date=>hold_date,:user_id=>session[:user_id])
        @event.save
      end #if
      # binding.pry
      @event = Event.where(name: hold_name)
      binding.pry
      redirect "events/#{@event[0].id}/edit"
    end

    get '/events/preedit' do
      @user = User.find(session[:user_id])
      @events = Event.where(user_id: "#{session[:user_id]}")
      @dishes = Dish.all
      @new_event_name = ""
      @new_event_date = ""
      @event = ""
      erb :'/events/preedit'
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

end
