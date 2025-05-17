# Weather Forecast API

A lightweight Ruby on Rails API that retrieves and caches current weather forecasts based on a given address.

## Features

- Accepts an address and geocodes it to retrieve weather data
- Returns:
  - Current temperature
  - Daily high and low
  - Feels like temperature
  - Weather summary (e.g., "clear sky")
- Caches results for 30 minutes

## Running Locally

### 1. Clone and install dependencies:

```bash
git clone https://github.com/mrdougwright/weather-api.git
cd weather-api
bundle install
```

### 2. Create a .env file.

See .env.example

```bash
OPENWEATHER_API_KEY=
REDIS_URL=
```

### 3. Start Redis & Server

```bash
redis-server
rails server
```

### 4. How to Use

With curl:
```bash
curl "http://localhost:3000/weather.json?address=Austin,TX"
```

With browser, go to `http://localhost:3000` and enter city & state into form.

#### Example JSON Response

```json
{
  "temperature": 85.0,
  "high": 88.0,
  "low": 80.0,
  "feels_like": 101.0,
  "summary": "clear sky",
  "from_cache": false
}
```

## Object Decomposition

This app is structured with separation of concerns in mind:

### Controllers
- WeatherController

Handles HTTP requests, orchestrates flow, and delegates to services. Supports both HTML and JSON output.

### Services
- ForecastParser

Parses raw API responses into a structured Ruby hash. Keeps transformation logic testable and independent.

- ForecastCache

Handles caching logic: retrieves forecasts from Redis if present, or fetches from OpenWeather and stores the result. Centralizes external API and caching logic outside the controller.

### Views
- index.html.erb

Provides a simple UI form for entering addresses and viewing the forecast results.

### Specs
Unit test for ForecastParser
Request spec for WeatherController simulates full request/response flow
