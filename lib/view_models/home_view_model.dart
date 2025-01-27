import 'package:app_admin/view_models/styles/my_color.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel {
  Logger logger = Logger();
  MyColor color = MyColor();
  ValueNotifier taiKhoanSaved = ValueNotifier('');
  ValueNotifier phanQuyenSaved = ValueNotifier('');
  
  Future<void> loadDataSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? taiKhoan = prefs.getString('tai-khoan');
    String? phanQuyen = prefs.getString('phan-quyen');
    taiKhoanSaved.value = taiKhoan;
    phanQuyenSaved.value = phanQuyen;
  }
}
