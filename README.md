>There's a lady who sures
>all that glitters is gold  
>and she's buying a stairway to heaven  -- Led Zeppelin

mini-train
=====

mini-train is an attempt to fork from a rack project(rack-golem) into
a very simple web mini-framework (thats the name mini-train)

Install with: (there are no gems yet, so don't try to install right now)

    sudo gem install mini-train

You can use config.ru as a start up file as for any rack app based

    require 'models' # Loads your models and all ORM stuff
    require 'app' # This is the main file
    require 'json' # Some help from other gems
    use Rack::ContentLength
    use Rack::Session::Cookies
    run App

Now save this into app.rb

    require 'minitrain'

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

	    def index(*args)
	      # When no public method is found
	      # Of course you don't have to declare one and it is gonna use Controller#not_found instead
	      # Still can have arguments
	      @articles = Post.all
	      erb :index
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
	      # So you can trigger this handler by visiting /best-restaurant.json
	      @res['Content-Type'] = "text/json"
	      JSON.generate({
	        'title' => 'Best restaurants in town',
	        'list' => Restaurant.full_list
	      })

	    def say(listener='me', *words)
	      "Hey #{listener} I don't need ERB to tell you that #{words.join(' ')}"
	    end

	    def not_found(*args)
	      # This one is defined by mini-train but here we decided to override it
	      # Like :index this method receives the arguments in order to make something with it
	      Email.alert('Too many people are looking for porn here') if args.includes?("porn")
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
	      Spy.analyse.send_info_to([:government, :facebook, :google, :james_bond])
	    end

	  end

You need to provide the class Post in your models.
Class Spy doesn't exist so you need to create it (he he, just kidding).

WHAT mini-train DOES NOT
===================

- Support templates other than ERB (It's a matter of time to support slim, haml and others)
- Session/Cookies administration (Like for many things, use a middleware instead ex: Rack::Session::Cookies)
- Prepare the coffee (Emacs does but i had never used it, just geany)
- So many things, but what is a fork for...
