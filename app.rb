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

  get '/register' do
    @registered = !params[:registered].nil?
    erb :register
  end

  post '/register' do
    @email = params[:email]
    @password = params[:password]
    Database.query('INSERT INTO users (email, pass) VALUES ($1, $2);', [@email, @password])
    redirect '/register?registered=1'
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

  run! if app_file == $0
end
