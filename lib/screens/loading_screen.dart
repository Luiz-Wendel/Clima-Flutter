import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:clima/utilities/openWheaterApiKey.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();

    await location.getCurrentLocation();

    latitude = location.getLatitude();
    longitude = location.getLongitude();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=$apiKey');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      int condition = decodedData['weather'][0]['id'];
      print(condition);
      double temperature = decodedData['main']['temp'];
      print(temperature);
      String cityName = decodedData['name'];
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
