import 'dart:convert';
import 'package:app_admin/provider/base/base.dart';
import 'package:app_admin/services/toast.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final String username;
  final String password;
  final bool isLoading;
  final bool isSaveAccount;

  LoginState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.isSaveAccount = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isSaveAccount,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSaveAccount: isSaveAccount ?? this.isSaveAccount,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(LoginState());
  final Ref ref;
  final Logger logger = Logger();

  void updateUsername(String? username) {
    state = state.copyWith(username: username);
  }

  void updatePassword(String? password) {
    state = state.copyWith(password: password);
  }

  void toggleSaveAccount(bool? value) {
    state = state.copyWith(isSaveAccount: value);
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username empty!";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password empty!";
    }
    return null;
  }

  Future<void> login(GlobalKey<FormState> formKey, GoRouter router,
      BuildContext context) async {
    final base = ref.watch(baseProvider);
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    state = state.copyWith(isLoading: true);

    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final dataPost = {
        'username': state.username,
        'password': state.password,
      };

      final response = await http.post(
        Uri.https(base.baseUrl, '/nguoi-dung/dang-nhap'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dataPost),
      );

      final json = jsonDecode(response.body);
      final status = json['status'];
      final message = json['response'];

      if (context.mounted) {
        showToast(context, message, ToastificationType.success);
      }

      if (status) {
        await sharedPreferences.setString('ho-ten', json['ho_ten']);
        await sharedPreferences.setString('phan-quyen', json['phan_quyen']);
        if (json['phan_quyen'] == base.authList[3]) {
          if (context.mounted) {
            showToast(context, 'Không thể đăng nhập', ToastificationType.error);
          }
          return;
        }
        String hashed = BCrypt.hashpw(json['phan_quyen'], BCrypt.gensalt());
        await sharedPreferences.setString('SSID', hashed);
        await sharedPreferences.setString('api-key', json['api_key']);
        await sharedPreferences.setBool('is-saved', state.isSaveAccount);
        router.go('/home');
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});
