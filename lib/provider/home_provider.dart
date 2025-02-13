import 'dart:convert';

import 'package:app_admin/models/can_ho_model.dart';
import 'package:app_admin/provider/base/base.dart';
import 'package:app_admin/provider/can_ho_provider.dart';
import 'package:app_admin/provider/middleware/middle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeState {
  final int selectedIndex;
  final String hoTen;
  final String phanQuyen;
  final String? ten_du_an;
  final String? ten_toa_nha;
  final String? loai_noi_that;
  final String? loai_can_ho;
  final String? huong_can_ho;
  final String? so_phong_ngu;
  final String? truc_can_ho;
  final String? loc_gia;
  final String? gia_tu;
  final String? gia_den;

  HomeState({
    this.selectedIndex = 0,
    this.hoTen = '',
    this.phanQuyen = '',
    this.ten_du_an = '',
    this.ten_toa_nha = '',
    this.loai_noi_that = '',
    this.loai_can_ho = '',
    this.huong_can_ho = '',
    this.so_phong_ngu = '',
    this.truc_can_ho = '',
    this.loc_gia = '',
    this.gia_tu = '',
    this.gia_den = '',
  });

  HomeState copyWith({
    int? selectedIndex,
    String? hoTen,
    String? phanQuyen,
    String? ten_du_an,
    String? ten_toa_nha,
    String? loai_noi_that,
    String? loai_can_ho,
    String? huong_can_ho,
    String? so_phong_ngu,
    String? truc_can_ho,
    String? loc_gia,
    String? gia_tu,
    String? gia_den,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      hoTen: hoTen ?? this.hoTen,
      phanQuyen: phanQuyen ?? this.phanQuyen,
      ten_du_an: ten_du_an ?? this.ten_du_an,
      ten_toa_nha: ten_toa_nha ?? this.ten_toa_nha,
      loai_noi_that: loai_noi_that ?? this.loai_noi_that,
      loai_can_ho: loai_can_ho ?? this.loai_can_ho,
      huong_can_ho: huong_can_ho ?? this.huong_can_ho,
      so_phong_ngu: so_phong_ngu ?? this.so_phong_ngu,
      truc_can_ho: truc_can_ho ?? this.truc_can_ho,
      loc_gia: loc_gia ?? this.loc_gia,
      gia_tu: gia_tu ?? this.gia_tu,
      gia_den: gia_den ?? this.gia_den,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ten_du_an': ten_du_an,
      'ten_toa_nha': ten_toa_nha,
      'loai_noi_that': loai_noi_that,
      'loai_can_ho': loai_can_ho,
      'huong_can_ho': huong_can_ho,
      'so_phong_ngu': so_phong_ngu,
      'truc_can_ho': truc_can_ho,
      'loc_gia': loc_gia,
      'gia_tu': gia_tu,
      'gia_den': gia_den,
    };
  }

  static HomeState fromMap(Map<String, dynamic> map) {
    return HomeState(
      ten_du_an: map['ten_du_an'],
      ten_toa_nha: map['ten_toa_nha'],
      loai_noi_that: map['loai_noi_that'],
      loai_can_ho: map['loai_can_ho'],
      huong_can_ho: map['huong_can_ho'],
      so_phong_ngu: map['so_phong_ngu'],
      truc_can_ho: map['truc_can_ho'],
      loc_gia: map['loc_gia'],
      gia_tu: map['gia_tu'],
      gia_den: map['gia_den'],
    );
  }
}

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(HomeState());
  final int limit = 50;
  String role = 'Sale';
  int offset = 0;
  int currentPage = 1;
  Logger logger = Logger();
  Ref ref;

  Future<void> loadDataSaved() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? apiKey = prefs.getString('api-key');
      if (apiKey == null) return;

      final base = ref.read(baseProvider);
      final response = await http.get(
        Uri.https(base.baseUrl, '/phan-quyen'),
        headers: {'Cookie': 'TOKEN=$apiKey'},
      );
      final json = jsonDecode(response.body);
      role = json['phan_quyen'];
      if (json['status']) {
        state = state.copyWith(
          hoTen: json['ho_ten'],
          phanQuyen: json['phan_quyen'],
        );
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void updateState({int? selectedIndex}) {
    state = state.copyWith(selectedIndex: selectedIndex);
  }

  void updateSelection(String? selection, String title) {
    final key = ref.read(baseProvider).getTempSelection[title];

    if (key != null) {
      final updatedMap = state.toMap();
      updatedMap[key] = selection;
      state = HomeState.fromMap(updatedMap);
    }
  }

  void tenDuAnUpdateSelection(selection) {
    state = state.copyWith(ten_du_an: selection);

    // final listTenToaNha = ref
    //     .watch(menuProvider)
    //     .value?['toa_nha']
    //     .where((item) => item['ten_du_an'].toString() == selection);

    // ref.read(listToaNhaProvider.notifier).state =
    //     List.from(listTenToaNha.map((item) => item['ten_toa_nha'].toString()));
  }

  Future<void> resetSelection() async {
    offset = 0;
    currentPage = 1;
    await ref.watch(canHoProvider.notifier).getData();
    state = HomeState();
  }

  Future<Map<String, dynamic>> fetchData(HomeState homeState) async {
    final base = ref.read(baseProvider);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? apiKey = sharedPreferences.getString('api-key');

    final response = await http.get(
      Uri.https(base.baseUrl, '/tim-kiem/$role', {
        'limit': '$limit',
        'offset': '$offset',
        ...homeState.toMap(),
      }),
      headers: {'Cookie': 'TOKEN=$apiKey'},
    );

    return jsonDecode(response.body);
  }

  Future<void> submitSelection() async {
    final canHoState = ref.read(canHoProvider.notifier);

    if (canHoState.state.isLoading) return;

    try {
      currentPage = 1;
      offset = 0;
      ref.read(middleProvider.notifier).state = true;
      canHoState.setLoading();

      final json = await fetchData(state);
      final status = json['status'];

      if (status) {
        final List<CanHoModel> listCanHo = List.from(
          json['data'].map((item) => CanHoModel.fromMap(item)),
        );

        canHoState.setList(listCanHo);
      }
    } catch (e, stackTrace) {
      canHoState.setError(e, stackTrace);
      logger.e(e);
    }
  }

  Future<bool> loadMore() async {
    final canHoState = ref.read(canHoProvider.notifier);
    final canHoNotifer = ref.read(canHoProvider);
    if (canHoNotifer.isLoading) return false;

    try {
      currentPage++;
      offset = (currentPage - 1) * limit;
      final json = await fetchData(state);
      final status = json['status'];

      if (!status) return false;

      final List<CanHoModel> listCanHo = List.from(
        json['data'].map((item) => CanHoModel.fromMap(item)),
      );

      final List<CanHoModel> updatedList = [
        ...(canHoNotifer.value ?? []),
        ...listCanHo
      ];

      if (listCanHo.isEmpty) return false;
      canHoState.setList(updatedList);
      return true;
    } catch (e, stackTrace) {
      logger.e(e);
      canHoState.setError(e, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('api-key');
    await sharedPreferences.remove('is-saved');
  }
}

final homeProvider =
    StateNotifierProvider<HomeProvider, HomeState>((ref) => HomeProvider(ref));

Future<Map<String, dynamic>> getListMenu(Ref ref) async {
  try {
    final base = ref.watch(baseProvider);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final apiKey = sharedPreferences.getString('api-key');

    final response = await http.get(
      Uri.https(base.baseUrl, "/thong-tin-du-an"),
      headers: {'Cookie': 'TOKEN=$apiKey'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {};
  } catch (e) {
    throw Exception(e);
  }
}

final menuProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return getListMenu(ref);
});

final listToaNhaProvider = StateProvider<List<dynamic>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['toa_nha']
        .map<String>((item) => item['ten_toa_nha'].toString())
        .toList() ??
    []);

final listTenDuAnProvider = StateProvider<List<String>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['toa_nha']
        .map<String>((item) => item['ten_du_an'].toString())
        .toSet()
        .toList() ??
    []);

final listNoiThatProvider = Provider<List<String>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['noi_that']
        ?.map<String>((item) => item['loai_noi_that'].toString())
        .toList() ??
    []);

final listLoaiCanHoProvider = Provider<List<String>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['loai_can_ho']
        ?.map<String>((item) => item['loai_can_ho'].toString())
        .toList() ??
    []);

final listHuongCanHoProvider = Provider<List<String>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['huong_can_ho']
        ?.map<String>((item) => item['huong_can_ho'].toString())
        .toList() ??
    []);

final listTrucCanHoProvider = Provider<List<String>>((ref) =>
    ref
        .watch(menuProvider)
        .value?['truc_can_ho']
        ?.map<String>((item) => item['truc_can'].toString())
        .toList() ??
    []);
