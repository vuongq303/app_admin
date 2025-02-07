import 'dart:convert';

import 'package:app_admin/provider/base/base.dart';
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
  final String? noi_that;
  final String? loai_can_ho;
  final String? huong_can_ho;
  final String? so_phong_ngu;
  final String? truc_can_ho;

  HomeState({
    this.selectedIndex = 0,
    this.hoTen = '',
    this.phanQuyen = '',
    this.ten_du_an = '',
    this.ten_toa_nha = '',
    this.noi_that = '',
    this.loai_can_ho = '',
    this.huong_can_ho = '',
    this.so_phong_ngu = '',
    this.truc_can_ho = '',
  });

  HomeState copyWith({
    int? selectedIndex,
    String? hoTen,
    String? phanQuyen,
    String? ten_du_an,
    String? ten_toa_nha,
    String? noi_that,
    String? loai_can_ho,
    String? huong_can_ho,
    String? so_phong_ngu,
    String? truc_can_ho,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      hoTen: hoTen ?? this.hoTen,
      phanQuyen: phanQuyen ?? this.phanQuyen,
      ten_du_an: ten_du_an ?? this.ten_du_an,
      ten_toa_nha: ten_toa_nha ?? this.ten_toa_nha,
      noi_that: noi_that ?? this.noi_that,
      loai_can_ho: loai_can_ho ?? this.loai_can_ho,
      huong_can_ho: huong_can_ho ?? this.huong_can_ho,
      so_phong_ngu: so_phong_ngu ?? this.so_phong_ngu,
      truc_can_ho: truc_can_ho ?? this.truc_can_ho,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ten_du_an': ten_du_an,
      'ten_toa_nha': ten_toa_nha,
      'noi_that': noi_that,
      'loai_can_ho': loai_can_ho,
      'huong_can_ho': huong_can_ho,
      'so_phong_ngu': so_phong_ngu,
      'truc_can_ho': truc_can_ho,
    };
  }

  static HomeState fromMap(Map<String, dynamic> map) {
    return HomeState(
      ten_du_an: map['ten_du_an'],
      ten_toa_nha: map['ten_toa_nha'],
      noi_that: map['noi_that'],
      loai_can_ho: map['loai_can_ho'],
      huong_can_ho: map['huong_can_ho'],
      so_phong_ngu: map['so_phong_ngu'],
      truc_can_ho: map['truc_can_ho'],
    );
  }
}

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(HomeState());
  Logger logger = Logger();
  Ref ref;

  Future<void> loadDataSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      hoTen: prefs.getString('ho-ten') ?? '',
      phanQuyen: prefs.getString('phan-quyen') ?? '',
    );
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

  void resetSelection() {
    state = HomeState();
  }

  Future<void> submitSelection() async {
    logger.d(state.toMap());
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('api-key');
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref);
});

Future<Map<String, dynamic>> getListMenu(Ref ref) async {
  try {
    final base = ref.watch(baseProvider);
    Logger logger = Logger();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final apiKey = sharedPreferences.getString('api-key');

    final response = await http.get(
      Uri.https(base.baseUrl, "/thong-tin-du-an"),
      headers: {'Cookie': 'TOKEN=$apiKey'},
    );
    logger.d('call api get list menu');
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
