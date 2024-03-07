import 'package:flutter/material.dart';
import 'weather_app.dart';

void main() {
  //can use Provider here to provide the data source
  // and then use context.read<DataSource>() in the widgets
  // and have multiple data sources extending the data source
  // can also use MultiProvider to provide multiple data sources
  runApp(const WeatherApp());
}


