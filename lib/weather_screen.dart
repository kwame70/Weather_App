import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/my_card.dart';
import 'package:weather_app/my_container.dart';
import 'package:weather_app/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/open_weather_api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "London";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey"));
      final data = jsonDecode(res.body);

      if (data["cod"] != "200") {
        throw "An unexpected error occured";
      }
      return data;
    } on http.ClientException {
      throw "Connection failed. Please retry";
    } catch (e) {
      throw e.toString();
    }
  }

  late final Future<Map<String, dynamic>> getWeather;
  @override
  void initState() {
    getWeather = getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          text: "Weather App",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getWeather = getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh_sharp))
        ],
      ),
      body: FutureBuilder(
        future: getWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentWeatherData = data["list"][0];
          final currentTemp = currentWeatherData["main"]["temp"];
          final weatherCond = currentWeatherData["weather"][0]["main"];
          final humidity = currentWeatherData["main"]["humidity"];
          final windSpeed = currentWeatherData["wind"]["speed"];
          final pressure = currentWeatherData["main"]["pressure"];

          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: MyMainCard(
                    // checking if weather condition is cloudy or rainy
                    icon: weatherCond == "Clouds" || weatherCond == "Rain"
                        ? Icons.cloud
                        : Icons.sunny,
                    temp: "$currentTemp K",
                    cond: weatherCond,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Weather forecast cards
                const MyText(
                  text: "Hourly Forecast",
                  fontSize: 24,
                ),
                const SizedBox(
                  height: 5,
                ),

                SizedBox(
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        final hourlyForecast = data["list"][index + 1];
                        final hourlyCond =
                            data["list"][index + 1]["weather"][0]["main"];
                        final time = DateTime.parse(hourlyForecast["dt_txt"]);
                        return MyCard(
                          time: DateFormat.j().format(time),
                          temp: hourlyForecast["main"]["temp"].toString(),
                          icon: hourlyCond.toString() == "Clouds" ||
                                  hourlyCond.toString() == "Rain"
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      })),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Additional information
                const MyText(
                  text: "Additional Information",
                  fontSize: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyContainer(
                        icon: Icons.water_drop_rounded,
                        condition: "Humidity",
                        temp: "$humidity"),
                    MyContainer(
                        icon: Icons.air_rounded,
                        condition: "Wind Speed",
                        temp: "$windSpeed"),
                    MyContainer(
                        icon: Icons.beach_access_rounded,
                        condition: "Pressure",
                        temp: "$pressure"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
