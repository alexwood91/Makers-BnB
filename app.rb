require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'setup_database'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  run! if app_file == $0
end