import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorWidgets extends StatelessWidget {
  const ErrorWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Error loading...'),
          TextButton(
            onPressed: () {
              router.pushReplacement('/login');
            },
            child: Text('Back to login'),
          ),
        ],
      ),
    );
  }
}
