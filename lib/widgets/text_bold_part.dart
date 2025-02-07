import 'package:flutter/material.dart';

class TextBoldPart extends StatelessWidget {
  const TextBoldPart({super.key, required this.title, required this.bold});
  final String title;
  final String bold;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: TextStyle(fontSize: 15),
        children: [
          TextSpan(
            text: bold,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
