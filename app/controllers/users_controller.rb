require './config/environment'
require "./app/models/user"

class UsersController < ApplicationController

    get "/" do
        erb :'users/index'
      end

    get "/signup" do
        erb :'users/signup'
    end
      
    post "/signup" do
        user = User.new(:name => params[:name], :password => params[:password])
        user.save
        # binding.pry
        if user.save && user.name != ""
            redirect "/login"
        else
            redirect "/failure"
        end
    end

    get "/login" do
        erb :'users/login'
      end
    
    post "/login" do
        # binding.pry
        @user = User.find_by(:name => params[:name])
        if @user && @user[:name]!="" && @user.authenticate(params[:password])
            # binding.pry
            session[:user_id] = @user.id
            redirect "/events/new"
        else
            erb :'users/failure'
        end
    end
    
    get "/logout" do
        session.clear
        redirect "/"
    end

end