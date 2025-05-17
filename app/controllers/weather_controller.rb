class WeatherController < ApplicationController
  def show
    # Geocode address from params
    address = params[:address]
    location = Geocoder.search(address).first
    lat, lon = location.latitude, location.longitude

    # Call Open Weather API
    # https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
    response = HTTP.get("https://api.openweathermap.org/data/2.5/weather", params: {
      lat: lat,
      lon: lon,
      appid: ENV["OPENWEATHER_API_KEY"]
    })

    unless response.status.success?
      render json: { error: "Failed to fetch weather data" }, status: :bad_gateway
      return
    end

    data = JSON.parse(response.body.to_s)

    render json: data
  end
end
