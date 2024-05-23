// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/model/weatherdata.dart';

import '../../repository/weatherdata.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(WeatherInitial()) {
    on<WeatherInitEvent>(weatherInitEvent);
    on<WeatherLoadingEvent>(weatherLoadingEvent);
  }

  FutureOr<void> weatherInitEvent(
      WeatherInitEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    await Future.delayed(const Duration(seconds: 4));
    try {
      final weatherData = await weatherRepository.fetchWeatherData();
      emit(WeatherLoaded(weatherData: weatherData));
      // print(weatherData.hourly.time);
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  FutureOr<void> weatherLoadingEvent(
      WeatherLoadingEvent event, Emitter<WeatherState> emit) {}
}
