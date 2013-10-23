require 'sinatra'
require 'active_record'
require 'pry'

###########################################################
# Configuration
###########################################################

set :public_folder, File.dirname(__FILE__) + '/public'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class Link < ActiveRecord::Base
	# create_table :links do |t|
	# 	t.string :url
	# 	t.string :shorturl
	# 	t.timestamps
	# end
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = [] # FIXME
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
	url = params[:url]
	hash = (Digest::SHA1.hexdigest url).slice(0,4) 
	p "--------------its hash is #{hash}"
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS

end
# this is the route that should handle all the redirects
get '/t/:hash' do
	iki = params[:hash]
	p "hello #{iki}"
end



# MORE ROUTES GO HERE