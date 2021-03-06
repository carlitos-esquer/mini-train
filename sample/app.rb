﻿require 'minitrain'
require 'slim'
require 'yaml'
require 'json'
class App
	include Minitrain # Still no classes to inherit but don't worry just await!

	before do
		# Here you can do many things
		# In order to help you here are some variables you can read and override:
		# @r => the Rack::Request object
		# @res => the Rack::Response object
		# @action => Name of the public method that will handle the request
		# @action_arguments => Arguments for the action (really?)
	end

	helpers do
		#altough you can write many things in before block
		#we recommend you to write helpers here to give your app some structure
		def simple
			"<b>Siempre genera BOLD</b>"
		end

    def json_response(data=nil)
			@res['Content-Type'] = "text/plain;charset=utf-8"
			data.nil? ? "{}" : JSON.generate(data)
    end
    
    def yaml_response(data=nil)
			@res['Content-Type'] = "text/plain;charset=utf-8"
			data.to_yaml
    end
    
	end

	def index(*args)
		# When no public method is found
		# Of course you don't have to declare one and it is gonna use Controller#not_found instead
		# Still can have arguments
		@articles = [{titulo: "hola mundo",contenido: "Este mundo material"},
								 {titulo: "bienvenidos", contenido: "Nunca habra paz..."},
								 {titulo: "el final", contenido: "como en los viejos tiempos"}
								]
		simple + (slim :index)
		#"<h1>Bienvenido</h1><br><h3>Hola mundo...</h3>"
	end

	def post(id=nil)
		@post = Post[id]
		if @post.nil?
			not_found
		else
			erb :post
		end
	end

	def best_restaurants_json
		# mini-train replaces dots and dashes with underscores
		# So you can trigger this handler by visiting /best-restaurants.json
		json_response({
			'title' => 'Best restaurants in town',
			'list' => "{ nuevo: 'artículo', antiguo: 'años'}"
		})
	end

	def best_restaurants_yaml
		#you can generate YAML responses (next time we will use XML)
		yaml_response({
			'title' => 'Best restaurants in town',
			'list' => "{ nuevo: 'artículo', antiguo: 'años'}"
		})
	end
	
	def envy(*args)
		@res['Content-Type'] = "text/html;charset=utf-8"
		my_res = ""
		my_res += "<p> Método: #{@r.request_method}</p>"
		my_res += "<p> Metodo: #{@r.query_string}</p>"
	end
	
	def say(listener='me', *words)
		"Hey #{listener} I don't need ERB to tell you that #{words.join(' ')}"
	end

	def not_found(*args)
		# This one is defined by mini-train but here we decided to override it
		# Like :index this method receives the arguments in order to make something with it
		#Email.alert('Too many people are looking for porn here') if args.includes?("porn")
		super(args)
	end

	def error(err, *args)
		# Again this one is defined by mini-train and only shows up when RACK_ENV is not `nil` or `dev` or `development`
		# Default only prints "ERROR"
		# Here we're going to send the error message
		# One would rarely show that to the end user but this is just a demo
		err.message
	end

	after do
		#Spy.analyse.send_info_to([:government, :facebook, :google, :james_bond])
	end
end

