class WeatherController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionController::MimeResponds


  def index
    render :index
  end

  def show
    address = params[:address]
    if address.blank?
      return respond_with_error("Address is required")
    end

    location = Geocoder.search(address).first
    if location.nil?
      return respond_with_error("Could not geocode address")
    end

    place_id, lat, lon = location.place_id, location.latitude, location.longitude

    begin
      @forecast = ForecastCache.fetch(place_id: place_id, lat: lat, lon: lon)
    rescue => e
      return respond_with_error(e.message)
    end

    respond_to do |format|
       format.html { render :index }
       format.json { render json: @forecast }
     end
  end

  private

  def respond_with_error(message)
    respond_to do |format|
      format.html do
        @error = message
        render :index
      end
      format.json { render json: { error: message }, status: :bad_request }
    end
  end
end
