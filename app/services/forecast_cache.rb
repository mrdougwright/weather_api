class ForecastCache
  CACHE_DURATION = 30.minutes

  def self.fetch(place_id:, lat:, lon:)
    cache_key = "forecast:#{place_id}"

    if (cached = Rails.cache.read(cache_key))
      puts "Forecast from cache. cache_key: #{cache_key}"
      return cached.merge(from_cache: true)
    end

    response = HTTP.get("https://api.openweathermap.org/data/2.5/weather", params: {
      lat: lat,
      lon: lon,
      appid: ENV["OPENWEATHER_API_KEY"],
      units: "imperial"
    })

    unless response.status.success?
      raise "Weather API error: #{response.status}"
    end

    data = JSON.parse(response.body.to_s)
    forecast = ForecastParser.parse(data)
    Rails.cache.write(cache_key, forecast, expires_in: CACHE_DURATION)

    forecast.merge(from_cache: false)
  end
end
