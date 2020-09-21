import 'package:flutter/material.dart';
import 'package:weather/pages/home.dart';

void main() {
  runApp(MaterialApp(
    title: "Weather App",
    theme: ThemeData(primaryColor: Colors.white),
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
