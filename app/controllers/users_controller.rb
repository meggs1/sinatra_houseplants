class UsersController < ApplicationController

    get '/signup' do 
        redirect_if_logged_in
        erb :"users/new"
    end

    post '/signup' do
        user = User.new(params[:user])

        if user.save
            session[:user_id] = user.id
            redirect_if_logged_in
        elsif user.username = User.find_by_username(params[:user][:username])
            flash[:username_taken] = "The username you entered is taken."
            redirect "/signup"
        else
            params.empty?
            flash[:fill_signup] = "Please fill out all fields."
            redirect "/signup"
        end
    end

    get '/index' do
        redirect_if_logged_in
        erb :"users/index"
    end

    post '/index' do
        user = User.find_by_username(params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session["user_id"] = user.id
            redirect_if_logged_in
        else
            flash[:no_login] = "Sorry, we couldnt find a user with that username/password."
            redirect "/index"
        end
    end

    delete '/logout' do
        redirect_if_not_logged_in
        session.clear
        redirect "/"
    end

end