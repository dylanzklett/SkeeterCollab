require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:flash_practice.sqlite3"

require './models'
enable :sessions

get '/' do
	erb :home
end

post '/signin' do


	redirect '/signedin'
end


post '/signup' do
		@current_user = User.new fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password]
		
	redirect
	'/signedin'
end

get '/signedin' do
	erb :signedin
	
end