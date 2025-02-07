import 'dart:convert';

import 'package:app_admin/models/can_ho_da_gui_model.dart';
import 'package:app_admin/provider/base/base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CanHoDaGuiProvider extends StateNotifier<AsyncValue<List<CanHoDaGuiModel>>> {
  CanHoDaGuiProvider(this.ref) : super(const AsyncValue.loading());
  Logger logger = Logger();
  final Ref ref;

  Future<void> getData() async {
    state = const AsyncValue.loading();
    final base = ref.watch(baseProvider);

    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? apiKey = sharedPreferences.getString('api-key');
      final response = await http.get(
        Uri.https(base.baseUrl, '/yeu-cau/danh-sach-duyet-yeu-cau'),
        headers: {'Cookie': 'TOKEN=$apiKey'},
      );
      final json = jsonDecode(response.body);
      final status = json['status'];
      if (status) {
        final List<CanHoDaGuiModel> listCanHo =
            List.from(json['data'].map((item) => CanHoDaGuiModel.fromMap(item)));

        state = AsyncValue.data(listCanHo);
        return;
      }
      state = AsyncValue.data([]);
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final canHoDaDuyetProvider =
    StateNotifierProvider<CanHoDaGuiProvider, AsyncValue<List<CanHoDaGuiModel>>>(
  (ref) => CanHoDaGuiProvider(ref),
);
