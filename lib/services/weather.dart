import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/untracked_constants.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=imperial');
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var openWeatherMapUrl = Uri.parse(
        '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&units=imperial&appid=$apiKey');
    // print('openWeatherMapUrl: $openWeatherMapUrl');

    NetworkHelper networkHelper = NetworkHelper(openWeatherMapUrl);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 77) {
      // 25 if using metric
      return 'It\'s 🍦 time';
    } else if (temp > 68) {
      // 20 if metric
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      // 10 if metric
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
