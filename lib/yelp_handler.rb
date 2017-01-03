# GET & HANDLES DATA FROM YELP API

class YelpHandler

  def self.get_by_coordinates(lat, long)
    client = setup_client
    data = client.search_by_coordinates({latitude: lat, longitude: long}, limit: 10, radius_filter: 100, sort: 1)

    output = data.businesses.map do |business|
       {
         name: business.name,categories: business.categories,rating: business.rating,
         coordinates: {lat: business.location.coordinate.latitude, long: business.location.coordinate.longitude},
         url: business.url
       }
    end

    return output
  end

  def self.get_by_business_name(name)
    client = setup_client
    data = client.business(name)

    output = data.businesses.map do |business|
       {
         name: business.name,categories: business.categories,rating: business.rating,
         location: {lat: business.location.coordinate.latitude, long: business.location.coordinate.longitude},
         url: business.url
       }
    end

    return output
  end

  private
  def self.setup_client

    client = Yelp::Client.new(
      {
        consumer_key: ENV['YELP_CONSUMER_KEY'],
        consumer_secret: ENV['YELP_CONSUMER_SECRET'],
        token: ENV['YELP_TOKEN'],
        token_secret: ENV['YELP_TOKEN_SECRET']
      }
    )

    client
  end

end
