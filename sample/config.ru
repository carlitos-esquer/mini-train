#require 'models' # Loads your models and all ORM stuff
require './app' # This is the main file
require 'json' # Some help from other gems
#use Rack::ContentLength
#use Rack::Session::Cookies
run App.new
