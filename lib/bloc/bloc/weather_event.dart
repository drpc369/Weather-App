part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherInitEvent extends WeatherEvent {}

class WeatherLoadingEvent extends WeatherEvent {}

class WeatherSuccessEvent extends WeatherEvent {}

class WeatherFailureEvent extends WeatherEvent {
  WeatherFailureEvent(this.error);

  final String error;
}
