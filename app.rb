require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require_relative 'setup_database'
require './lib/room'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions 
    configure :test, :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  before do
    @user = User.find_userid(session[:userid])
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
      session[:userid] = user.userid
      redirect '/rooms'
    else
      flash[:error] = :error_wrong_password
      redirect '/sessions/new'
    end
  end

  post '/sessions/delete' do
    session.clear
    flash[:status] = :status_signed_out
    redirect '/'
  end
  
  get '/rooms' do
    @rooms = Room.all
    erb :'rooms/index'
  end

  post '/rooms' do
    if @user
      Room.create(name: params[:new_room], description: params[:description], price: params[:price], datefrom: params[:datefrom], dateto: params[:dateto], userid: @user.userid)
      redirect '/rooms'
    else
      redirect'/sessions/new'
    end
  end

  get '/rooms/new' do
    if @user
      erb :'rooms/new'
    else
      redirect '/sessions/new'
    end
  end
  
  get '/rooms/manage' do
    @rooms = Room.find_mine(userid: session[:userid])
    erb :'/rooms/manage'
  end
  
  post '/rooms/delete' do
    Room.delete(id: params[:roomid] )
    redirect 'rooms/manage'
  end
  

  get '/rooms/request' do
    @rooms = Room.all
    erb :'rooms/request'
  end
  
  post '/rooms/request' do
    @rooms = Room.all
    @bookfrom = params[:bookfrom]
    @bookto = params[:bookto]
    erb :'rooms/confirmed_request'
  end

  run! if app_file == $0
end
