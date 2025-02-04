import 'package:flutter/material.dart';

class ConditionWidget extends StatelessWidget {
  const ConditionWidget({
    super.key,
    required this.widgetTrue,
    required this.widgetFalse,
    required this.condition,
  });
  final Widget widgetTrue;
  final Widget widgetFalse;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return condition ? widgetTrue : widgetFalse;
  }
}
