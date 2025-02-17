import 'package:app_admin/provider/base/base.dart';
import 'package:app_admin/provider/can_ho_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/services/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:app_admin/models/can_ho_model.dart';
import 'package:app_admin/widgets/text_bold_part.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:toastification/toastification.dart';

class CanHoItem extends ConsumerWidget {
  const CanHoItem({super.key, required this.canHo, required this.index});
  final CanHoModel canHo;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(stylesProvider);
    final base = ref.watch(baseProvider);

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
          Row(
            children: [
              Text('Mã căn hộ: ', style: TextStyle(fontSize: 15)),
              Container(
                padding: const EdgeInsets.all(2),
                color: color.convertColor(canHo.danh_dau),
                child: Text(
                  '${canHo.ten_toa_nha}-${canHo.ma_can_ho == '' ? 'x' : canHo.ma_can_ho}${canHo.truc_can_ho}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
            '- ${canHo.nguoi_cap_nhat} đã cập nhật ngày ${DateFormat("dd/MM/yyyy").format(canHo.ngay_cap_nhat.add(Duration(days: 1)))}',
          ),
          const SizedBox(height: 10),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  final listImage = canHo.hinh_anh.split(',');
                  if (listImage[0].isEmpty) return;
                  final listImageUrl = List.from(
                    listImage.map(
                      (img) =>
                          Uri.https(base.baseUrl, '/can-ho/${canHo.id}/$img')
                              .toString(),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (context) => Stack(
                      children: [
                        PhotoViewGallery.builder(
                          scrollPhysics: const BouncingScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: NetworkImage(listImageUrl[index]),
                              initialScale:
                                  PhotoViewComputedScale.contained * 1,
                              heroAttributes:
                                  PhotoViewHeroAttributes(tag: index),
                            );
                          },
                          itemCount: listImageUrl.length,
                          loadingBuilder: (context, event) => Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: color.bgColor,
                              size: 50,
                            ),
                          ),
                          onPageChanged: (int? num) {},
                        ),
                        Positioned(
                          right: 15,
                          top: 15,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 25,
                              color: color.whColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
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
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: color.bgColor,
                        size: 30,
                      ),
                    ),
                  );
                  try {
                    final response =
                        await ref.read(yeuCauProvider(canHo.id).future);
                    if (!context.mounted) return;
                    if (response['status']) {
                      showToast(context, response['response'],
                          ToastificationType.success);

                      return;
                    }

                    showToast(context, response['response'],
                        ToastificationType.error);
                  } catch (error) {
                    showToast(
                        context, 'Có lỗi xảy ra', ToastificationType.error);
                  } finally {
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
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
