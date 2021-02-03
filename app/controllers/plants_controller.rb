class PlantsController < ApplicationController

    get '/plants' do
        redirect_if_not_logged_in
        @user = User.find(session["user_id"])
        @plants = @user.plants
        erb :"plants/index"
    end


end