import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String message, ToastificationType type) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flatColored,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 2),
    alignment: Alignment.bottomCenter,
  );
}
