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
        binding.pry
        @events = Event.where(user_id: "#{session[:user_id]}")
        @dishes = Dish.all
        @new_event_name = ""
        @new_event_date = ""
        # @events = Event.all
        # @dishes = Dish.all
        binding.pry 
        erb :'/events/new'
    end
    
     post '/events' do
      binding.pry
      if !Event.exists?(name: "#{@new_event_name}")
        @event = Event.new(:name=>"#{@new_event_name}",:date=>"#{@new_event_date}",:user_id=>session[:user_id])
        @event.save
      end #if
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

end
