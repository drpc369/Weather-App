import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/repository/weatherdata.dart';

import 'bloc/bloc/weather_bloc.dart';

void main() {
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: WeatherApp()));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

//-6.1722  35.7395
class _WeatherAppState extends State<WeatherApp> {
  WeatherBloc weatherBloc = WeatherBloc(
      weatherRepository: WeatherRepository(
          baseUrl:
              'https://api.open-meteo.com/v1/forecast?latitude=-6.1722&longitude=35.7395&current=temperature_2m,relative_humidity_2m,rain&hourly=temperature_2m,relative_humidity_2m,dew_point_2m&daily=temperature_2m_max,temperature_2m_min'));
  @override
  void initState() {
    weatherBloc.add(WeatherInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Forecasting App'),
          centerTitle: true,
        ),
        backgroundColor: const Color(0XFFB6FFFA),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bcloud.jpg', // Path to your image file
                fit: BoxFit.cover,
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 170,
                      ),
                      Text(
                        'Dodoma Weather',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF365486)),
                      ),
                      Text(
                        ' Condition',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF0B60B0),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocConsumer<WeatherBloc, WeatherState>(
                    bloc: weatherBloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Color(0XFF0B60B0),
                            ),
                            Text(
                              "dodoma weather data fetching",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF365486),
                              ),
                            )
                          ],
                        );
                      }
                      if (state is WeatherLoaded) {
                        double latitude = state.weatherData.latitude;
                        double longtitude = state.weatherData.longitude;
                        double temperature =
                            state.weatherData.current.temperature2m;
                        double rain = state.weatherData.current.rain;
                        int humidity =
                            state.weatherData.current.relativeHumidity2m;
                        String time = state.weatherData.current.time;

                        return Column(children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.only(left: 20),
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(
                                  0XFFFBA1B7), // Set the background color of the container
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0XFFE3E1D9).withOpacity(
                                      0.5), // Set the color and opacity of the shadow
                                  spreadRadius:
                                      3, // Set the spread radius of the shadow
                                  blurRadius:
                                      7, // Set the blur radius of the shadow
                                  offset: const Offset(
                                      0, 2), // Set the offset of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color(0XFF0B60B0),
                                ),
                                Text(
                                  time.substring(0, 10),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'latitude',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0XFF0B60B0)),
                                    ),
                                    Text(
                                      '$latitude',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0XFF365486)),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'longitude',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0XFF0B60B0)),
                                    ),
                                    Text(
                                      '$longtitude',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0XFF365486)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // First container with text
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),

                                        color: Colors
                                            .white, // Set the background color of the container
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFC5FFF8)
                                                .withOpacity(
                                                    0.5), // Set the color and opacity of the shadow
                                            spreadRadius:
                                                5, // Set the spread radius of the shadow
                                            blurRadius:
                                                7, // Set the blur radius of the shadow
                                            offset: const Offset(0,
                                                3), // Set the offset of the shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/rain.png',
                                              width: 40,
                                            ),
                                            Text(
                                              '${rain}mm',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(0XFF365486)),
                                            ),
                                            const Text(
                                              'Rain',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Color(0XFF0B60B0)),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                // Second container with text
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),

                                        color: Colors
                                            .white, // Set the background color of the container
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFC5FFF8)
                                                .withOpacity(
                                                    0.5), // Set the color and opacity of the shadow
                                            spreadRadius:
                                                5, // Set the spread radius of the shadow
                                            blurRadius:
                                                7, // Set the blur radius of the shadow
                                            offset: const Offset(0,
                                                3), // Set the offset of the shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/hum.png',
                                              width: 40,
                                            ),
                                            Text(
                                              '$humidity%',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(0XFF365486)),
                                            ),
                                            const Text(
                                              'Humidity',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Color(0XFF0B60B0)),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                // Third container with text
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),

                                        color: Colors
                                            .white, // Set the background color of the container
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFC5FFF8)
                                                .withOpacity(
                                                    0.5), // Set the color and opacity of the shadow
                                            spreadRadius:
                                                5, // Set the spread radius of the shadow
                                            blurRadius:
                                                7, // Set the blur radius of the shadow
                                            offset: Offset(0,
                                                3), // Set the offset of the shadow
                                          ),
                                        ],
                                      ),
                                      width: 120,
                                      height: 120,
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/temp.png',
                                              width: 40,
                                            ),
                                            Text(
                                              '$temperature°C',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(0XFF365486)),
                                            ),
                                            const Text(
                                              'Temperature',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Color(0XFF0B60B0)),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }
                      if (state is WeatherFailure) {
                        return Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/internet.jpg',
                                width: 180,
                              ),
                              Text(
                                'Connect To The Strong Internet !!',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
