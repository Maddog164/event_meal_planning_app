require './config/environment'
require "./app/models/event"

class Events_Controller < Sinatra::Base

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
       @dishes = dish.all
       erb :'/events/new'
    end

end
