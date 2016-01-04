require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:flash_practice.sqlite3"

require './models'
enable :sessions

get '/' do
'Hello World!'
end