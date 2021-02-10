class PlantsController < ApplicationController

    before '/plants/*' do
        redirect_if_not_logged_in
    end

    get '/plants' do
        redirect_if_not_logged_in
        @user = User.find(session["user_id"])
        @plants = @user.plants
        erb :"plants/index"
    end

    get '/plants/new' do
        @user = current_user
        erb :'plants/new'
    end

    get '/plants/:id' do
        @plant = Plant.find_by(id: params[:id])
        erb :"/plants/show"
    end

    post '/plants' do
        @plant = Plant.create(params[:plant])
        @user = current_user
        if @plant.name.empty? || @plant.nickname.empty?
            flash[:plant_failure] = "Plants need a 'type' and a 'nickname'."
            redirect "/plants/new"
        else
            @user.plants << plant
            redirect "/plants"
        end
    end

    get '/plants/:id/edit' do
        @user = current_user
        @plant = Plant.find_by(id: params[:id])
        erb :"/plants/edit"
    end

    patch '/plants/:id' do
        @plant = Plant.find_by_id(params[:id])
        @plant.update(params["plant"])
        if @plant.name.empty? || @plant.nickname.empty?
            flash[:edit_plant_failure] = "Plants need a 'type' and a 'nickname'."
            redirect "/plants/#{@plant.id}/edit"
        else
            redirect "/plants/#{@plant.id}"
        end
    end

    delete '/plants/:id' do
        plant = Plant.find_by(id: params[:id])
        plant.delete
        redirect "/plants"
    end

end