import 'dart:convert';

import 'package:app_admin/models/can_ho_model.dart';
import 'package:app_admin/provider/base/base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CanHoProvider extends StateNotifier<AsyncValue<List<CanHoModel>>> {
  CanHoProvider(this.ref) : super(const AsyncValue.loading());
  Logger logger = Logger();
  final Ref ref;

  Future<void> getData(int limit, int offset) async {
    state = const AsyncValue.loading();
    final base = ref.watch(baseProvider);

    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? apiKey = sharedPreferences.getString('api-key');
      final response = await http.get(
        Uri.https(base.baseUrl, '/can-ho', {
          'limit': limit.toString(),
          'offset': offset.toString(),
        }),
        headers: {'Cookie': 'TOKEN=$apiKey'},
      );
      final json = jsonDecode(response.body);
      final status = json['status'];
      if (status) {
        final List<CanHoModel> listCanHo =
            List.from(json['data'].map((item) => CanHoModel.fromMap(item)));

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

Future<Map<String, dynamic>> guiYeuCau(int id, Ref ref) async {
  Logger logger = Logger();

  try {
    final base = ref.watch(baseProvider);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final apiKey = sharedPreferences.getString('api-key');

    final response = await http.post(
      Uri.https(base.baseUrl, '/yeu-cau/gui-yeu-cau'),
      headers: {
        'Cookie': 'TOKEN=$apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'can_ho': id.toString()}),
    );

    final responseData = jsonDecode(response.body);
    return responseData;
  } catch (e) {
    logger.e(e);
    return {'status': false, 'response': 'Lỗi kết nối'};
  }
}

final yeuCauProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, int>(
  (ref, id) => guiYeuCau(id, ref),
);

final canHoProvider =
    StateNotifierProvider<CanHoProvider, AsyncValue<List<CanHoModel>>>(
  (ref) => CanHoProvider(ref),
);
