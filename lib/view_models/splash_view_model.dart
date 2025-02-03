import 'dart:convert';

import 'package:app_admin/services/base.dart';
import 'package:app_admin/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class SplashViewModel {
  Logger logger = Logger();
  Base base = Base();

  Future<bool> authLogin(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? apiKey = sharedPreferences.getString('api-key');

      await Future.delayed(const Duration(seconds: 1));
      if (apiKey == null) {
        return false;
      }

      final auth = {
        'api_key': apiKey,
      };

      final data = await http.post(
        Uri.https(base.baseUrl, '/auth'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(auth),
      );

      final Map<String, dynamic> response = jsonDecode(data.body);
      final status = response['status'];

      if (!status) {
        final message = response['status'];
        if (context.mounted) {
          showToast(context, message, ToastificationType.error);
        }
      }
      return status;
    } catch (e) {
      if (context.mounted) {
        showToast(context, 'Đã xảy ra lỗi', ToastificationType.error);
      }
      return false;
    }
  }
}
