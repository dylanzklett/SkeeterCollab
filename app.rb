require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

configure(:development){set :database, "sqlite3:flash_practice.sqlite3"}

require './models'
enable :sessions

def current_user
	if session[:user_id]
		@current_skeeter = User.find(session[:user_id])
	end
end

get '/' do
	erb :home
end

post '/' do
	@skeeter = User.where(email: params[:email]).first
	if params[:password] == @skeeter.password
		session[:user_id] = @skeeter.id
		flash[:notice] = "Hope you're ready to skeet!"
		redirect '/signedin'
	else
		flash[:notice] = 'Try again, darkness my old friend!'
		redirect '/'
	end
end


post '/signup' do
		@skeeter = User.new(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password])
		if @skeeter.save 
			flash[:notice] = "Hope you're ready to skeet!"
			session[:user_id] = @skeeter.id
			redirect '/signedin'
		else
			flash[:notice] = "Try again, darkness my old friend."
		end
end

get '/signedin' do
	@skeeter = current_user
	erb :signedin
end

get '/edit' do 
	erb :edit
end

post '/signedin' do 
	@skeeter = current_user
	@skeets = Skeet.all
	if params[:fname] && params[:lname] && params[:email] && params[:password] != nil
		@skeeter.update(fname: params[:fname])
		@skeeter.update(lname: params[:lname]) 
		@skeeter.update(email: params[:email]) 
		@skeeter.update(password: params[:password])
		redirect '/signedin'
	end
end

get '/newpost' do
	@skeets = Skeet.all
	@user = current_user
	# @skeets = Skeet.create( body: params[:body])
	erb :newpost

end

post '/newpost' do
	@user = current_user
	@skeets = Skeet.new(body: params[:body])
		if @skeets.save
			flash[:notice] ="Aww, look at that sweet Skeet!"
			redirect '/newpost'
		else
			flash[:notice] ="Your Skeet is simply not up to par."
			redirect '/'
		end
end

# post '/editpost'
# 'Hello World!'
# end

get '/logout' do
 	session.clear
	redirect '/'
	flash[:notice] = "Hope to Skeet with you again!"
end

get '/destroy' do
	@current_skeeter = current_user
	User.destroy(@current_skeeter)
	redirect '/'
end
