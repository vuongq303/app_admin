import 'package:flutter_riverpod/flutter_riverpod.dart';

class Base {
  String get baseUrl => 'api.connecthome.vn';
  Map<String, String> get getTempSelection => {
        'Tên dự án': 'ten_du_an',
        'Tên tòa nhà': 'ten_toa_nha',
        'Nội thất': 'loai_noi_that',
        'Loại căn hộ': 'loai_can_ho',
        'Hướng ban công': 'huong_can_ho',
        'Số phòng ngủ': 'so_phong_ngu',
        'Trục căn hộ': 'truc_can_ho',
        'Giá từ': 'gia_tu',
        'Giá đến': 'gia_den',
        'Lọc giá': 'loc_gia',
      };
}

final baseProvider = Provider<Base>((ref) => Base());
