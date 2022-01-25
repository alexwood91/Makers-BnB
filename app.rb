require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'setup_database'
require './lib/room'
require './lib/user'

class MakersBnb < Sinatra::Base
  configure :development do
    enable :sessions # make sessions hash available
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
    erb :'sign-in'
  end

  post '/sign-in' do
    @email = params[:email]
    @password = params[:password]
    result = Database.query('SELECT email, pass FROM users WHERE email=$1;', [@email])
    if result.ntuples >= 1 && result[0]['pass'] == @password
      'You are now signed in'
    else
      'Incorrect password'
    end
  end
  
  get '/available' do
    @rooms = Room.all
    erb :viewing_rooms
  end

  run! if app_file == $0
end
