import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'b900fb0a31ea176b4c2a1aeb3cd034a7';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getWeatherData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&units=imperial&appid=$apiKey');
    // print(url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      String data = response.body;
      var decodedData = jsonDecode(data);

      int condition = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String city = decodedData['name'];
      print('condition: $condition; temp: $temperature; city: $city');
    } else {
      print('request failed with status:  ${response.statusCode}.');
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
