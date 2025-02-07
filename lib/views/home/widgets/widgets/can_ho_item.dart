import 'package:app_admin/provider/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:app_admin/models/can_ho_model.dart';
import 'package:app_admin/widgets/text_bold_part.dart';
import 'package:flutter/material.dart';

class CanHoItem extends ConsumerWidget {
  const CanHoItem({super.key, required this.canHo, required this.index});
  final CanHoModel canHo;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(stylesProvider);

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBoldPart(title: 'STT: ', bold: (index + 1).toString()),
          TextBoldPart(
            title: 'Mã căn hộ: ',
            bold:
                '${canHo.ten_toa_nha}-${canHo.ma_can_ho == '' ? 'x' : canHo.ma_can_ho}${canHo.truc_can_ho}',
          ),
          TextBoldPart(
            title: 'Chủ căn hộ: ',
            bold: canHo.chu_can_ho == "" ? 'x' : canHo.chu_can_ho,
          ),
          TextBoldPart(
            title: 'Số điện thoại: ',
            bold: canHo.so_dien_thoai == "" ? 'x' : canHo.so_dien_thoai,
          ),
          TextBoldPart(
              title: 'Giá bán: ',
              bold: NumberFormat("#,###").format(canHo.gia_ban)),
          TextBoldPart(
              title: 'Giá thuê: ',
              bold: NumberFormat("#,###").format(canHo.gia_thue)),
          Text('Thông tin dự án'),
          TextBold(
            '- ${canHo.ten_du_an} - ${canHo.dien_tich}m² - ${canHo.so_phong_ngu}PN${canHo.so_phong_tam}WC - ${canHo.huong_can_ho}',
          ),
          TextBold('- ${canHo.loai_can_ho}'),
          TextBold('- ${canHo.noi_that}'),
          TextBold('- ${canHo.ghi_chu}'),
          TextBold(
            '- ${canHo.nguoi_cap_nhat} đã cập nhật ngày ${DateFormat("dd/MM/yyyy").format(canHo.ngay_cap_nhat)}',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    canHo.hinh_anh == '' ? color.bgColor : color.yellow,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    canHo.hinh_anh == '' ? color.whColor : color.bgColor,
                  ),
                ),
                child: Text('Hình ảnh'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    const EdgeInsets.symmetric(horizontal: 40),
                  ),
                  backgroundColor: WidgetStatePropertyAll(color.redOrange),
                  foregroundColor: WidgetStatePropertyAll(color.whColor),
                ),
                child: Text('Yêu cầu'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget TextBold(title) => Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );
}
