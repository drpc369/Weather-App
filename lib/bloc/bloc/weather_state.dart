// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherData weatherData;
  WeatherLoaded({
    required this.weatherData,
  });
}

class WeatherFailure extends WeatherState {
  WeatherFailure(this.error);

  final String error;
}
