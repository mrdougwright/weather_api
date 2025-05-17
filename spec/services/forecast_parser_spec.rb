require 'rails_helper'

RSpec.describe ForecastParser do
  let(:api_response) do
    {
      "main" => {
        "temp" => 87.0,
        "temp_max" => 90.0,
        "temp_min" => 82.0,
        "feels_like" => 101.0
      },
      "weather" => [
        { "description" => "hot as hades" }
      ]
    }
  end

  it "parses the forecast data correctly" do
    result = ForecastParser.parse(api_response)

    expect(result).to eq({
      temperature: 87.0,
      high: 90.0,
      low: 82.0,
      feels_like: 101.0,
      summary: "hot as hades"
    })
  end
end
