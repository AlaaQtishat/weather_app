class WeatherResponse {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final List<WeatherData> data;
  final String? prev;
  final String? next;

  WeatherResponse({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.data,
    this.prev,
    this.next,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      timezone: json['timezone'] as String? ?? '',
      timezoneOffset: json['timezone_offset'] as int? ?? 0,
      data: json['data'] != null
          ? List<WeatherData>.from(
              (json['data'] as List).map((x) => WeatherData.fromJson(x)),
            )
          : [],
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }
}

class WeatherData {
  final int dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;

  final Temperature temp;
  final Temperature feelsLike;

  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final double? windGust;
  final int windDeg;
  final double? pop; // Probability of precipitation

  final Precipitation? rain;
  final Precipitation? snow;
  final List<WeatherCondition> weather;
  final List<String>? alerts;

  WeatherData({
    required this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    this.windGust,
    required this.windDeg,
    this.pop,
    this.rain,
    this.snow,
    required this.weather,
    this.alerts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      dt: json['dt'] as int? ?? 0,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
      moonrise: json['moonrise'] as int?,
      moonset: json['moonset'] as int?,
      moonPhase: (json['moon_phase'] as num?)?.toDouble(),

      temp: Temperature.fromJson(json['temp']),
      feelsLike: Temperature.fromJson(json['feels_like']),

      pressure: (json['pressure'] as num?)?.toInt() ?? 0,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
      clouds: (json['clouds'] as num?)?.toInt() ?? 0,
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      windDeg: (json['wind_deg'] as num?)?.toInt() ?? 0,
      pop: (json['pop'] as num?)?.toDouble(),

      rain: json['rain'] != null ? Precipitation.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? Precipitation.fromJson(json['snow']) : null,

      weather: json['weather'] != null
          ? (json['weather'] as List)
                .map<WeatherCondition>((x) => WeatherCondition.fromJson(x))
                .toList()
          : [],
      alerts: json['alerts'] != null ? List<String>.from(json['alerts']) : null,
    );
  }

  static WeatherData get dummy => WeatherData(
    dt: 1787575190,
    temp: Temperature(current: 25.0, min: 15.0, max: 28.0),
    feelsLike: Temperature(current: 22.0),
    pressure: 1012,
    humidity: 50,
    dewPoint: 10.0,
    uvi: 5.0,
    clouds: 20,
    visibility: 10000,
    windSpeed: 4.5,
    windDeg: 180,
    pop: 0.2,
    weather: [
      WeatherCondition(
        id: 800,
        main: 'Clear',
        description: 'Loading...',
        icon: '01d',
      ),
    ],
  );
}

class Temperature {
  final double current;
  final double? min;
  final double? max;
  final double? morn;
  final double? day;
  final double? eve;
  final double? night;

  Temperature({
    required this.current,
    this.min,
    this.max,
    this.morn,
    this.day,
    this.eve,
    this.night,
  });

  factory Temperature.fromJson(dynamic json) {
    if (json == null) return Temperature(current: 0.0);

    if (json is num) {
      return Temperature(current: json.toDouble());
    } else if (json is Map<String, dynamic>) {
      return Temperature(
        current: (json['day'] as num?)?.toDouble() ?? 0.0,
        min: (json['min'] as num?)?.toDouble(),
        max: (json['max'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
        day: (json['day'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        night: (json['night'] as num?)?.toDouble(),
      );
    }
    return Temperature(current: 0.0);
  }
}

class Precipitation {
  final double h1;

  Precipitation({required this.h1});

  factory Precipitation.fromJson(Map<String, dynamic> json) {
    return Precipitation(h1: (json['1h'] as num?)?.toDouble() ?? 0.0);
  }
}

class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'] as int? ?? 0,
      main: json['main'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }
}
