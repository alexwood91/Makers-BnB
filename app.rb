require 'sinatra/base'
require 'sinatra/reloader'
require './lib/room'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/available' do
    @room = Room.new("Premier Inn")
    erb :viewing_rooms
  end

  run! if app_file == $0
end