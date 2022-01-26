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

  before do
    @user = User.find_id(session[:id])
  end

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    User.create(email: params[:email], password: params[:password])
    session.clear
    redirect '/sessions/new?registered=true'
  end

  get '/sessions/new' do
    @error = params[:error]
    @registered = !params[:registered].nil?
    erb :'/sessions/new'
  end

  post '/sessions' do
    user = User.signin(email: params[:email], password: params[:password])
    if user
      session[:id] = user.id
      redirect '/'
    else
      redirect '/sessions/new?error=password'
    end
  end

  post '/sessions/delete' do
    session.clear
    redirect '/'
  end

  get '/available' do
    @rooms = Room.all
    erb :viewing_rooms
  end

  run! if app_file == $0
end
