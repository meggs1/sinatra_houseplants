class PlantsController < ApplicationController

    get '/plants' do
        redirect_if_not_logged_in
        @user = User.find(session["user_id"])
        @plants = @user.plants
        erb :"plants/index"
    end

    get '/plants/new' do
        redirect_if_not_logged_in
        user = current_user
        erb :'plants/new'
    end

    get '/plants/:id' do
        redirect_if_not_logged_in
        @plant = Plant.find_by(id: params[:id])
        erb :"/plants/show"
    end

    post '/plants' do
        redirect_if_not_logged_in
        plant = Plant.create(params[:plant])
        @user = current_user

        if !params["plant"]["name"].empty?
            @user.plants << plant
            redirect "/plants"
        end
    end

    get '/plants/:id/edit' do
        redirect_if_not_logged_in
        @user = current_user
        @plant = Plant.find_by(id: params[:id])
        erb :"/plants/edit"
    end

    patch '/plants/:id' do
        redirect_if_not_logged_in
        plant = Plant.find_by(id: params[:id])
        plant.update(params["plant"])
        redirect "/plants/#{@plant.id}"
    end

    delete '/plants/:id' do
        redirect_if_not_logged_in
        plant = Plant.find_by(id: params[:id])
        plant.delete
        redirect "/plants"
    end





end