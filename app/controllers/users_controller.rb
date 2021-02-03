class UsersController < ApplicationController

    get '/signup' do 
        redirect_if_logged_in
        erb :"users/new"
    end

    post '/signup' do
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect "/plants"
        else
            #add flash error message
            redirect "/signup"
        end
    end

    get '/login' do #render login form
        redirect_if_logged_in
        erb :"users/login"
    end

    post '/login' do #creates session
        user = User.find_by(:username => params["username"])
        if user && user.authenticate(params["password"])
            session["user_id"] = user.id #logs user in and sets session id
            redirect "/plants"
        else
            redirect "/login"
        end
    end

    delete '/logout' do #destroys session
        session.clear
        redirect "/"
    end

end