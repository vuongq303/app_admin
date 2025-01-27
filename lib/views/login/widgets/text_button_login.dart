import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_admin/view_models/styles/my_color.dart';

class TextButtonLogin extends StatelessWidget {
  final Function() onClick;
  final String title;
  final String action;

  const TextButtonLogin(
      {super.key,
      required this.onClick,
      required this.title,
      required this.action});

  @override
  Widget build(BuildContext context) {
    final color = context.read<MyColor>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color.gray,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: onClick,
          child: Text(
            action,
            style: TextStyle(
              color: color.redOrange,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
