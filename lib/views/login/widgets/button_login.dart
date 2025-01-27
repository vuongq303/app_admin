import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final double maxWidth;
  final String title;
  final Function() onClick;
  final Color textColor;
  final Color bgColor;

  const ButtonLogin({
    super.key,
    required this.maxWidth,
    required this.onClick,
    required this.title,
    required this.textColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
