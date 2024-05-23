// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weatherdata.dart';

class WeatherRepository {
  final String baseUrl;
  WeatherRepository({
    required this.baseUrl,
  });

  Future<WeatherData> fetchWeatherData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> weatherdata = json.decode(response.body);

      return WeatherData.fromJson(weatherdata);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
