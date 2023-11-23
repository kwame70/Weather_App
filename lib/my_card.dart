import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/my_text.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.time, required this.temp});
  final String time;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            MyText(
              text: time,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 8,
            ),
            const Icon(
              Icons.cloud,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            MyText(
              text: temp,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}

class MyMainCard extends StatelessWidget {
  const MyMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                MyText(
                  text: "300 °F",
                  fontSize: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.cloud,
                  size: 64,
                ),
                SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "Rain",
                  fontSize: 20,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
