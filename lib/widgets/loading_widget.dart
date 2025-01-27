import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoading(BuildContext context, Color color) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.black.withValues(alpha: 255),
            ),
          ),
          Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: color,
              size: 50,
            ),
          )
        ],
      );
    },
  );
}
