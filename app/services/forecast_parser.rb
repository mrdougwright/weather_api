class ForecastParser
  def self.parse(data)
    {
      temperature: data.dig("main", "temp"),
      high:        data.dig("main", "temp_max"),
      low:         data.dig("main", "temp_min"),
      feels_like:  data.dig("main", "feels_like"),
      summary:     data.dig("weather", 0, "description")
    }
  end
end
