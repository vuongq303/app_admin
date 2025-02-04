import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoading(BuildContext context, Color color) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: color,
          size: 50,
        ),
      );
    },
  );
}
