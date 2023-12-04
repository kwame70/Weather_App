import 'dart:convert';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          text: "Weather App",
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_sharp))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentTemp = data["list"][0]["main"]["temp"];

          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: MyMainCard(
                    icon: Icons.water,
                    temp: "$currentTemp K",
                    cond: "rain",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Weather forecast cards
                const MyText(
                  text: "Weather Forecast",
                  fontSize: 24,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MyCard(
                        time: "9:00",
                        temp: "300.12",
                        icon: Icons.cloud,
                      ),
                      MyCard(
                        time: "1:00",
                        temp: "200.11",
                        icon: Icons.sunny,
                      ),
                      MyCard(
                        time: "7:00",
                        temp: "100.20",
                        icon: Icons.cloud,
                      ),
                      MyCard(time: "3:00", temp: "210.21", icon: Icons.sunny),
                      MyCard(
                        time: "10:00",
                        temp: "100.12",
                        icon: Icons.cloud,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Additional information
                const MyText(
                  text: "Additional Information",
                  fontSize: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyContainer(
                        icon: Icons.water_drop_rounded,
                        condition: "Humidity",
                        temp: "94"),
                    MyContainer(
                        icon: Icons.air_rounded,
                        condition: "Wind Speed",
                        temp: "7.67"),
                    MyContainer(
                        icon: Icons.beach_access_rounded,
                        condition: "Pressure",
                        temp: "1006"),
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
