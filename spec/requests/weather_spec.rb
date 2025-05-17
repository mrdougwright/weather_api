require 'ostruct'
require 'rails_helper'

RSpec.describe "Weather API", type: :request do
  before do
    allow(Geocoder).to receive(:search).and_return([
      OpenStruct.new(latitude: 30.2672, longitude: -97.7431)
    ])

    allow(HTTP).to receive(:get).and_return(
      instance_double(HTTP::Response, status: double(success?: true), body: {
        "main" => { "temp" => 85.0, "temp_max" => 88.0, "temp_min" => 80.0 },
        "weather" => [{ "description" => "clear sky" }],
        "dt" => Time.now.to_i
      }.to_json)
    )
  end

  it "returns weather data for a given address" do
    get "/weather", params: { address: "Austin, TX" }, headers: { "ACCEPT" => "application/json" }

    expect(Geocoder).to have_received(:search).with("Austin, TX")
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)

    expect(json).to include("temperature", "high", "low", "summary")
  end
end
