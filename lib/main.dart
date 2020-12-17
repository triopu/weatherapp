import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weatherapp/screens/splash.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      home: SplashScreen(),
    );
  }
}
