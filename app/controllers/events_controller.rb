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
      binding.pry
      hold_name = params[:"@new_event_name"]
      hold_date = params[:"@new_event_date"]
      if Event.where("name = ? AND date = ?", "Caturday","November7,2020") == []
        # if this event name with this date does not exist, create a new event with 
        # these attributes
        @event = Event.new(:name=>hold_name,:date=>hold_date,:user_id=>session[:user_id])
        @event.save
        binding.pry
      end #if
      # binding.pry
      @event = Event.where(["name=? and date=?","#{hold_name}", "#{hold_date}"])
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

    patch '/events/:id' do 
      binding.pry
      @event = Event.find(params[:id])
      hold_name = params[:"event"]["name"]
      hold_date = params[:"event"]["date"]
      if !hold_name == @event.name || !hold_date == @event.date
        #update event name and date with new name and date entered
        @event.update(name: hold_name,date: hold_date)
      end
      if !params[:"dish"]["name"]==""
        #creating new dish that was entered and associating that dish with the event
        new_dish_name = params[:"dish"]["name"]
        new_dish_type = params[:"dish"]["type"]
        new_dish_id = params[:"dish"]["id"] 
        new_dish = Dish.new(:name=> new_dish_name, :type => new_dish_type)
        Eventdish.new(:event_id => params[:id], :dish_id => new_dish_id)
      end 
      binding.pry

      
    end

end
