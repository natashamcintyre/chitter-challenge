require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/user.rb'
require_relative './database_connection.rb'

class Chitter < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/peeps' do
    @peeps = Peep.all.order(created_at: :desc)
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/save_peep' do
    Peep.create(params[:peep])
    redirect '/peeps'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/save_user' do
    user = User.create(params[:user])
    redirect "/users/#{user.id}/welcome"
  end

  get '/users/:id/welcome' do
    @user = User.find_by(id: params[:id])
    erb :'users/welcome'
  end
end