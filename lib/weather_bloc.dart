// weather_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'event.dart';
import 'state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(WeatherError("No internet connection"));
      return;
    }

    try {
      final weather = await _fetchWeather(event.cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError("Could not fetch weather. Is the device online?"));
    }
  }

  Future<Weather> _fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=8d850b323ef8cd239ffe2812370e143a&units=metric'),
    );

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("Failed to load weather");
    }

    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }
}
