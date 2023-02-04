# app/controllers/museums_controller.rb
class MuseumsController < ApplicationController
  require "open-uri"
  require "json"

  def new
  end

  def create
    lat = params[:lat]
    lng = params[:lng]


    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=#{lat}%2C#{lng}&types=poi&access_token=pk.eyJ1IjoiZ2FtYmFyZXkiLCJhIjoiY2xiNTNtdmF2MDFzYjN2cGc1YWUxYWpheSJ9.3-9J0sjLcCTBT6jdZ5NIXg"
    response = URI.open(url).read
    @data = JSON.parse(response)

    # Parse the response and group the museums by postcode
    @museums_by_postcode = {}
    @data["features"].each_with_index do |museum, index| #["features"].select.group_by{ |feature| feature["context"][0]["id"] }
      @museums_by_postcode[museum["context"][0]["id"].split(".").second] = [museum["text"]]
    end
    redirect_to museums_path(lat: lat, lng: lng)
  end

  def index
    lat = params[:lat]
    lng = params[:lng]

    # Make a request to the Mapbox API using the lat and lng parameters
    # response = HTTParty.get("https://api.mapbox.com/geocoding/v5/mapbox.places/museums.json?lat=#{lat}&lng=#{lng}&access_token=pk.eyJ1IjoiZ2FtYmFyZXkiLCJhIjoiY2xiNTNtdmF2MDFzYjN2cGc1YWUxYWpheSJ9.3-9J0sjLcCTBT6jdZ5NIXg")

    #   # Send a request to the Mapbox API to retrieve the museums around the given GPS location
    #url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museums.json?lat=#{lat}&lng=#{lng}&access_token=pk.eyJ1IjoiZ2FtYmFyZXkiLCJhIjoiY2xiNTNtdmF2MDFzYjN2cGc1YWUxYWpheSJ9.3-9J0sjLcCTBT6jdZ5NIXg"
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=#{lat}%2C#{lng}&types=poi&access_token=pk.eyJ1IjoiZ2FtYmFyZXkiLCJhIjoiY2xiNTNtdmF2MDFzYjN2cGc1YWUxYWpheSJ9.3-9J0sjLcCTBT6jdZ5NIXg"
    response = URI.open(url).read
    @data = JSON.parse(response)

    # Parse the response and group the museums by postcode
    @museums_by_postcode = {}
    @data["features"].each_with_index do |museum, index| #["features"].select.group_by{ |feature| feature["context"][0]["id"] }
      @museums_by_postcode[museum["context"][0]["id"].split(".").second] = [museum["text"]]
    end
  end

  # MAPBOX_API_URL = 'https://api.mapbox.com/search/v1/suggest/%2Fmuseums'

  # def index
  #   latitude = params[:latitude].to_f
  #   longitude = params[:longitude].to_f
  #   radius = params[:radius].to_f
  #   categories = 'museum'

  #   # Send a request to the Mapbox API to retrieve the museums around the given GPS location
  #   url = "#{MAPBOX_API_URL}#{longitude},#{latitude}.json?limit=50&radius=#{radius}&categories=#{categories}&access_token=<pk.eyJ1IjoiZ2FtYmFyZXkiLCJhIjoiY2xiNTNtdmF2MDFzYjN2cGc1YWUxYWpheSJ9.3-9J0sjLcCTBT6jdZ5NIXg>"
  #   uri = URI(url)
  #   response = Net::HTTP.get(uri)
  #   data = JSON.parse(response)

  #   # Extract the museum names and postcodes from the API response
  #   museums = {}
  #   data['features'].each do |feature|
  #     name = feature['text']
  #     postcode = feature['properties']['postcode']
  #     museums[postcode] ||= []
  #     museums[postcode] << name
  #   end

  #   render json: {museums: museums}
  # end
end
