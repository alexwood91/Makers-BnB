require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'setup_database'
require './lib/room'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions # make sessions hash available
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/register' do
    @user = User.find(session[:id])
    erb :register
  end

  post '/register' do
    user = User.create(email: params[:email], password: params[:password])
    session[:id] = user.id
    redirect '/register'
  end

  get '/sign-in' do
    @user = User.find(session[:id])
    erb :'sign-in'
  end

  post '/sign-in' do
    user = User.signin(email: params[:email], password: params[:password])
    User.find(user.id)
    session[:id] = user.id
    p "sessiona after signin:"
    p session
    redirect '/sign-in'
  end
  
  get '/available' do
    @rooms = Room.all
    erb :viewing_rooms
  end

  post '/logoff' do
    session.clear
    redirect '/'
  end
  run! if app_file == $0
end
