import 'dart:convert';

import 'package:app_admin/provider/base/base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends StateNotifier<AsyncValue<bool>> {
  SplashProvider(this.ref) : super(const AsyncValue.loading());
  Logger logger = Logger();
  final Ref ref;

  Future<void> authLogin() async {
    try {
      state = const AsyncValue.loading();
      final base = ref.watch(baseProvider);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? apiKey = sharedPreferences.getString('api-key');
      bool? isSaved = sharedPreferences.getBool('is-saved') ?? false;
      await Future.delayed(const Duration(seconds: 1));

      if (!isSaved) {
        state = const AsyncValue.data(false);
        return;
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
      state = AsyncValue.data(status);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final splashProvider = StateNotifierProvider<SplashProvider, AsyncValue<bool>>(
  (ref) => SplashProvider(ref),
);
