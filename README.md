# Weather Forecast API

A lightweight Ruby on Rails API that retrieves and caches current weather forecasts based on a given address.

## Features

- Accepts an address and geocodes it to retrieve weather data
- Returns:
  - Current temperature
  - Daily high and low
  - Feels like temperature
  - Weather summary (e.g., "clear sky")
- Caches results by place_id for 30 minutes

## Modules

- **`ForecastParser`**: Encapsulates logic for transforming raw API response into a clean Ruby hash
- **`WeatherController`**: Handles request flow, delegates geocoding, parsing, and caching

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
curl "http://localhost:3000/weather?address=Austin,TX"
```

#### Example Response

```json
{
  "temperature": 85.0,
  "high": 88.0,
  "low": 80.0,
  "feels_like": 101.0,
  "summary": "clear sky",
  "from_cache": false
}
