# require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'sinatra/base'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/controllers_loader'


class BookmarkManager < Sinatra::Base



enable :sessions
set :session_secret, 'super secret'
set :public_folder, File.join(root, '..', 'public') 
set :views, File.join(root, '..', 'views')
use Rack::MethodOverride
use Rack::Flash

configure do
  register Sinatra::Partial
  set :partial_template_engine, :erb
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
