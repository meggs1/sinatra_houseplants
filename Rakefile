require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :env do
    require "./config/environment"
end

task :console => :env do
    Pry.start
end
