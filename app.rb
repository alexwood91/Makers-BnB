require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'setup_database'
require './lib/room'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions # make sessions hash available
    configure :test, :development do
    register Sinatra::Reloader
  end

  before do
    @user = User.find_userid(session[:userid])
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
      session[:userid] = user.userid
      redirect '/rooms'
    else
      redirect '/sessions/new?error=password'
    end
  end

  post '/sessions/delete' do
    session.clear
    redirect '/'
  end
  
  get '/rooms' do
    @rooms = Room.all
    erb :viewing_rooms
  end

  post '/rooms' do
    Room.create(name: params[:new_room], description: params[:description], price: params[:price], datefrom: params[:datefrom], dateto: params[:dateto])
    redirect '/rooms'
  end

  get '/rooms/new' do
    erb :new
  end

  run! if app_file == $0
end
