import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeState {
  final int selectedIndex;
  final String hoTen;
  final String phanQuyen;
  final String? tenDuAn;
  final String? tenToaNha;
  final String? noiThat;
  final String? loaiCanHo;
  final String? huongBanCong;
  final String? soPhongNgu;
  final String? trucCanHo;

  HomeState({
    this.selectedIndex = 0,
    this.hoTen = '',
    this.phanQuyen = '',
    this.tenDuAn,
    this.tenToaNha,
    this.noiThat,
    this.loaiCanHo,
    this.huongBanCong,
    this.soPhongNgu,
    this.trucCanHo,
  });

  HomeState copyWith({
    int? selectedIndex,
    String? hoTen,
    String? phanQuyen,
    String? tenDuAn,
    String? tenToaNha,
    String? noiThat,
    String? loaiCanHo,
    String? huongBanCong,
    String? soPhongNgu,
    String? trucCanHo,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      hoTen: hoTen ?? this.hoTen,
      phanQuyen: phanQuyen ?? this.phanQuyen,
      tenDuAn: tenDuAn ?? this.tenDuAn,
      tenToaNha: tenToaNha ?? this.tenToaNha,
      noiThat: noiThat ?? this.noiThat,
      loaiCanHo: loaiCanHo ?? this.loaiCanHo,
      huongBanCong: huongBanCong ?? this.huongBanCong,
      soPhongNgu: soPhongNgu ?? this.soPhongNgu,
      trucCanHo: trucCanHo ?? this.trucCanHo,
    );
  }
}

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider() : super(HomeState());
  Logger logger = Logger();

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

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('api-key');
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider();
});
