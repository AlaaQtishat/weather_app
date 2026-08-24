class WeatherAssets {
  static String getCustomIcon(String iconCode) {
    const Map<String, String> icons = {
      '01d': 'assets/images/weather/sun.png',
      '02d': 'assets/images/weather/sun_cloud.png',
      '03d': 'assets/images/weather/morn_clouds.png',
      '04d': 'assets/images/weather/morn_clouds.png',
      '09d': 'assets/images/weather/morn_rain.png',
      '10d': 'assets/images/weather/morn_sun_rain.png',
      '11d': 'assets/images/weather/morn_thunder.png',
      '13d': 'assets/images/weather/morn_snow.png',
      '50d': 'assets/images/weather/morn_winds.png',

      '01n': 'assets/images/weather/moon.png',
      '02n': 'assets/images/weather/moon_cloud.png',
      '03n': 'assets/images/weather/night_clouds.png',
      '04n': 'assets/images/weather/night_clouds.png',
      '09n': 'assets/images/weather/night_rain.png',
      '10n': 'assets/images/weather/night_moon_rain.png',
      '11n': 'assets/images/weather/night_thunder.png',
      '13n': 'assets/images/weather/night_snow.png',
      '50n': 'assets/images/weather/night_winds.png',
    };
    return icons[iconCode] ?? 'assets/images/weather/morn_clouds.png';
  }
}
