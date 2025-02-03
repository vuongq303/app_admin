import 'package:app_admin/styles/my_color.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel {
  Logger logger = Logger();
  MyColor color = MyColor();

  ValueNotifier hoTenSaved = ValueNotifier('');
  ValueNotifier phanQuyenSaved = ValueNotifier('');
  ValueNotifier<String?> tenDuAnSelected = ValueNotifier('');
  ValueNotifier<String?> tenToaNhaSelected = ValueNotifier('');
  ValueNotifier<String?> noiThatSelected = ValueNotifier('');
  ValueNotifier<String?> loaiCanHoSelected = ValueNotifier('');
  ValueNotifier<String?> huongBanCongSelected = ValueNotifier('');
  ValueNotifier<String?> soPhongNguSelected = ValueNotifier('');
  ValueNotifier<String?> trucCanHoSelected = ValueNotifier('');

  Future<void> loadDataSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hoTen = prefs.getString('ho-ten');
    String? phanQuyen = prefs.getString('phan-quyen');
    hoTenSaved.value = hoTen;
    phanQuyenSaved.value = phanQuyen;
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('api-key');
  }
}
