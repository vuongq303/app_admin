import 'dart:convert';

import 'package:app_admin/services/base.dart';
import 'package:app_admin/services/toast.dart';
import 'package:app_admin/styles/my_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LoginViewModel {
  MyColor color = MyColor();
  Base base = Base();
  Logger logger = Logger();

  String usernameInputForm = '';
  String passwordInputForm = '';

  void onSaveUsernameInputForm(String? value) {
    usernameInputForm = value!;
  }

  void onSavePasswordInputForm(String? value) {
    passwordInputForm = value!;
  }

  String? onVaidatorUsernameInputForm(String? value) {
    if (value == "") {
      return "Username empty!";
    }
    return null;
  }

  String? onVaidatorPasswordInputForm(String? value) {
    if (value == "") {
      return "Password empty!";
    }
    return null;
  }

  Future<void> onSubmitFormLogin(
    GlobalKey<FormState> key,
    GoRouter router,
    BuildContext context,
    bool isSaveAccount,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      if (key.currentState!.validate()) {
        key.currentState!.save();

        final dataPost = {
          'username': usernameInputForm,
          'password': passwordInputForm,
        };

        final data = await http.post(
          Uri.https(base.baseUrl, '/nguoi-dung/dang-nhap'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(dataPost),
        );

        Map<String, dynamic> json = jsonDecode(data.body);
        final response = json['response'];
        final status = json['status'];

        if (context.mounted) {
          showToast(context, response, ToastificationType.success);
        }

        if (status) {
          final hoTen = json['ho_ten'];
          final phanQuyen = json['phan_quyen'];

          await sharedPreferences.setString('ho-ten', hoTen);
          await sharedPreferences.setString('phan-quyen', phanQuyen);

          if (isSaveAccount) {
            final apiKey = json['api_key'];
            await sharedPreferences.setString('api-key', apiKey);
          }
          router.go('/home');
        }
        return;
      }
    } catch (e) {
      logger.e(e);
      if (context.mounted) {
        showToast(
          context,
          'Đăng nhập không thành công',
          ToastificationType.error,
        );
      }
    }
  }
}
