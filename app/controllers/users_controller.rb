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