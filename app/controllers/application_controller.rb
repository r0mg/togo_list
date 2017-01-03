require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/activerecord'
require 'json'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set views: "app/views"
    set :public_folder, 'app/assets'
  end

  get '/' do
    erb :index
  end

  post '/locate' do
    # SETUP COORDINATES
    @lat = params[:lat].to_f
    @lon = params[:lon].to_f

    # GET YELP DATA
    @yelp_data = YelpHandler.get_by_coordinates(@lat, @lon)
    @yelp_locations = @yelp_data.collect { |r| [r[:coordinates][:lat],r[:coordinates][:long], r[:name]] }

    erb :location
  end

  post '/bookmark' do
    bookmark = Bookmark.new(name: params['bookmark_name'],
                            link: params['bookmark_link'])

    if bookmark.save!
        json status: "#{bookmark.name} bookmark created."
    else
        json status: 'An Error Has Occured'
    end
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all

    erb :bookmarks
  end
end
