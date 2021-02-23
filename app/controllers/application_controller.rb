class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    set :views, 'app/views'

    get '/' do
        redirect_if_logged_in
        erb :"/users/index"
    end

    error Sinatra::NotFound do
        flash[:page_does_not_exist] = "That page does not exist."
        redirect '/'
    end

    helpers do 
        def current_user
            User.find_by_id(session["user_id"]) if session["user_id"]
        end

        def logged_in?
            !!current_user
        end

        def redirect_if_not_logged_in
            if !logged_in? 
                flash[:not_logged_in] = "You need to be logged in to do this."
                redirect "/"
            end 
        end

        def redirect_if_logged_in
            redirect "/plants" if logged_in?
        end
    end

end