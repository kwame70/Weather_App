import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight = FontWeight.bold});
  final String text;
  final FontWeight fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
