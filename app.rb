require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require_relative 'setup_database'
require './lib/room'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions # make sessions hash available
    configure :test, :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  before do
    @user = User.find_id(session[:id])
  end

  get '/' do
    erb :index
  end

  get '/users/new' do
    if @user
      redirect '/'
    else
      erb :'/users/new'
    end
  end

  post '/users' do
    error = :error_password_confirm if params[:password] != params[:password_confirm]
    error = :error_password_length if params[:password].length < 8
    error = :error_valid_email unless params[:email] =~ URI::MailTo::EMAIL_REGEXP
    if error
      flash[:error] = error
      return redirect '/users/new'
    end

    User.create(email: params[:email], password: params[:password])
    session.clear
    flash[:status] = :status_registered
    redirect '/sessions/new'
  end

  get '/sessions/new' do
    if @user
      redirect '/'
    else
      erb :'/sessions/new'
    end
  end

  post '/sessions' do
    user = User.signin(email: params[:email], password: params[:password])
    if user
      session[:id] = user.id
      redirect '/'
    else
      flash[:error] = :error_wrong_password
      redirect '/sessions/new'
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

  get '/rooms/request' do
    @rooms = Room.all
    erb :request
  end
  
  post '/rooms/request' do
    @rooms = Room.all
    @bookfrom = params[:bookfrom]
    @bookto = params[:bookto]
    erb :confirmed_request
  end

  run! if app_file == $0
end
