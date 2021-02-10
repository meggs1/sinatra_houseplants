class UsersController < ApplicationController

    get '/signup' do 
        redirect_if_logged_in
        erb :"users/new"
    end

    post '/signup' do
        user = User.new(params)
        user_info = {
            :name => params["name"],
            :username => params["username"],
            :password => params["password"]
        }

        if user.save
            session[:user_id] = user.id
            flash[:welcome] = "Welcome to Houseplant helper!"
            redirect "/plants"
        elsif user.username = User.find_by_username(user_info[:username])
            flash[:username_taken] = "The username you entered is taken."
            redirect "/signup"
        else
            user_info.empty?
            flash[:fill_signup] = "Please fill out all fields."
            redirect "/signup"
        end
    end

    get '/index' do #render login form
        redirect_if_logged_in
        erb :"users/index"
    end

    post '/index' do #creates session
        user = User.find_by(:username => params["username"])
        if user && user.authenticate(params["password"])
            session["user_id"] = user.id #logs user in and sets session id
            redirect "/plants"
        else
            redirect "/index"
        end
    end

    delete '/logout' do #destroys session
        session.clear
        redirect "/"
    end

end