import 'package:flutter/material.dart';
import 'package:weather_app/my_text.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      required this.icon,
      required this.condition,
      required this.temp});
  final IconData icon;
  final String condition;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
          ),
          const SizedBox(
            height: 8,
          ),
          MyText(
            text: condition,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(
            height: 8,
          ),
          MyText(
            text: temp,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
