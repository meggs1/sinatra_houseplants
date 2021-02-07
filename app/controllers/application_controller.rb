class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']



    get '/' do
        redirect_if_logged_in
        erb :"/users/index"
    end

    helpers do #in controller because i'm going to use them in my views
        def current_user
            User.find_by_id(session["user_id"]) if session["user_id"] #returns nil (.find returns false)
        end

        def logged_in?
            !!current_user #if the current user exists
        end
    end

    private

    def redirect_if_not_logged_in #added here to make code more dry
        if !logged_in? 
            flash[:not_logged_in] = "You need to be logged in to do this."
            redirect "/"
        end 
    end

    def redirect_if_logged_in #added here to make code more dry
        redirect "/plants" if logged_in?
    end
    
end