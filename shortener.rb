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
end

###########################################################
# Routes
###########################################################

get '/' do
  @links = Link.find(:all)# FIXME
  erb :index
end

get '/new' do
    erb :form
end

post '/new' do
  url = params[:url]
  description = params[:description]
  hash = (Digest::SHA1.hexdigest url).slice(0,4)
  #checks for existing item:
  if not Link.exists?(:short_url => hash)
    # adds new link to database
    Link.create(:full_url => url,
                :short_url => hash,
                :description => description)
  end
  p "t/#{hash}" #shows new link made
end

# this is the route that should handle all the redirects
get '/t/:hash' do
  link = Link.find_by_short_url(params[:hash])
  # link.visits = link.visits + 1
  # link.save
  p "will redirect to: #{link.full_url}"
  redirect "http://#{link.full_url}"
end