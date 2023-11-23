import 'package:flutter/material.dart';
import 'package:weather_app/my_card.dart';
import 'package:weather_app/my_text.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: MyMainCard(),
            ),
            SizedBox(
              height: 20,
            ),
            //Weather forecast cards
            MyText(
              text: "Weather Forecast",
              fontSize: 24,
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyCard(time: "9:00", temp: "300.12"),
                  MyCard(time: "8:00", temp: "200.11"),
                  MyCard(time: "7:00", temp: "100.20"),
                  MyCard(time: "6:00", temp: "210.21"),
                  MyCard(time: "10:00", temp: "100.12"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
