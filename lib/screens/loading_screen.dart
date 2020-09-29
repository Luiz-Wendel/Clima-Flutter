import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/openWheaterApiKey.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocationData() async {
    Location location = Location();

    await location.getCurrentLocation();

    latitude = location.getLatitude();
    longitude = location.getLongitude();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    int condition = weatherData['weather'][0]['id'];
    print(condition);
    double temperature = weatherData['main']['temp'];
    print(temperature);
    String cityName = weatherData['name'];
    print(cityName);
  }

  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
