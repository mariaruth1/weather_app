import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_app/models.dart';
import 'package:http/http.dart' as http;

class FakeDataSource {
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final json = await rootBundle.loadString('assets/weekly_forecast.json');
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }
}

class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    const url = "https://api.open-meteo.com/v1/forecast?latitude=55.4703&longitude=8.4519&daily=weather_code,temperature_2m_max,temperature_2m_min&wind_speed_unit=ms&timezone=Europe%2FBerlin";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeeklyForecastDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load joke");
    }
  }
}