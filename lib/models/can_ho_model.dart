class CanHoModel {
  final int id;
  final int gia_ban;
  final int gia_thue;
  final int trang_thai;
  final String ma_can_ho;
  final String ten_du_an;
  final String dien_tich;
  final int so_phong_ngu;
  final int so_phong_tam;
  final String huong_can_ho;
  final String loai_can_ho;
  final String noi_that;
  final String ghi_chu;
  final String nguoi_cap_nhat;
  final String hinh_anh;
  final String ten_toa_nha;
  final String truc_can_ho;
  final String chu_can_ho;
  final String so_dien_thoai;
  final String danh_dau;
  final DateTime ngay_cap_nhat;

  CanHoModel({
    required this.id,
    required this.gia_ban,
    required this.gia_thue,
    required this.trang_thai,
    required this.ma_can_ho,
    required this.ten_du_an,
    required this.dien_tich,
    required this.so_phong_ngu,
    required this.so_phong_tam,
    required this.huong_can_ho,
    required this.loai_can_ho,
    required this.noi_that,
    required this.ghi_chu,
    required this.nguoi_cap_nhat,
    required this.hinh_anh,
    required this.ten_toa_nha,
    required this.truc_can_ho,
    required this.chu_can_ho,
    required this.so_dien_thoai,
    required this.danh_dau,
    required this.ngay_cap_nhat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gia_ban': gia_ban,
      'gia_thue': gia_thue,
      'trang_thai': trang_thai,
      'ma_can_ho': ma_can_ho,
      'ten_du_an': ten_du_an,
      'dien_tich': dien_tich,
      'so_phong_ngu': so_phong_ngu,
      'so_phong_tam': so_phong_tam,
      'huong_can_ho': huong_can_ho,
      'loai_can_ho': loai_can_ho,
      'noi_that': noi_that,
      'ghi_chu': ghi_chu,
      'nguoi_cap_nhat': nguoi_cap_nhat,
      'hinh_anh': hinh_anh,
      'ten_toa_nha': ten_toa_nha,
      'truc_can_ho': truc_can_ho,
      'chu_can_ho': chu_can_ho,
      'so_dien_thoai': so_dien_thoai,
      'danh_dau': danh_dau,
      'ngay_cap_nhat': ngay_cap_nhat.toIso8601String(),
    };
  }

  factory CanHoModel.fromMap(Map<String, dynamic> map) {
    return CanHoModel(
      id: map['id'] ?? 0,
      gia_ban: map['gia_ban'] ?? 0,
      gia_thue: map['gia_thue'] ?? 0,
      trang_thai: map['trang_thai'] ?? 0,
      ma_can_ho: map['ma_can_ho'] ?? "",
      ten_du_an: map['ten_du_an'] ?? "",
      dien_tich: map['dien_tich'] ?? "",
      so_phong_ngu: map['so_phong_ngu'] ?? "",
      so_phong_tam: map['so_phong_tam'] ?? "",
      huong_can_ho: map['huong_can_ho'] ?? "",
      loai_can_ho: map['loai_can_ho'] ?? "",
      noi_that: map['noi_that'] ?? "",
      ghi_chu: map['ghi_chu'] ?? "",
      nguoi_cap_nhat: map['nguoi_cap_nhat'] ?? "",
      hinh_anh: map['hinh_anh'] ?? "",
      ten_toa_nha: map['ten_toa_nha'] ?? "",
      truc_can_ho: map['truc_can_ho'] ?? "",
      chu_can_ho: map['chu_can_ho'] ?? "",
      so_dien_thoai: map['so_dien_thoai'] ?? "",
      danh_dau: map['danh_dau'] ?? "",
      ngay_cap_nhat: DateTime.parse(map['ngay_cap_nhat'] ?? ""),
    );
  }
}
