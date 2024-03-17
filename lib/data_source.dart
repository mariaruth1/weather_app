import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_app/models.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

abstract class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast();
  Future<WeatherChartData> getChartData();
}

class FakeDataSource implements DataSource{
  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final json = await rootBundle.loadString('assets/weekly_forecast.json');
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }

  @override
  Future<WeatherChartData> getChartData() async {
    final json = await rootBundle.loadString("assets/chart_data.json");
    return WeatherChartData.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource{
  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    var location = await Location.instance.getLocation();
    var url = Uri.https("api.open-meteo.com", '/v1/forecast', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'daily': 'weather_code,temperature_2m_max,temperature_2m_min',
      'wind_speed_unit': 'ms',
      'timezone': 'Europe/Berlin',
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return WeeklyForecastDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  @override
  Future<WeatherChartData> getChartData() async {
    const apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=55.4703&longitude=8.4519&daily=temperature_2m_max,temperature_2m_min&wind_speed_unit=ms&timezone=Europe%2FBerlin";
    final response = await http.get(Uri.parse(apiUrl));
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }
}