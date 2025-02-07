import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<String> downloadAllImages(List<String> imageUrls) async {
  List<String> errors = [];

  for (String url in imageUrls) {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
       Uint8List bytes = response.bodyBytes;

      // Lưu ảnh vào thư viện
      final result = await ImageGallerySaver.saveImage(bytes);
        print('✅ Đã tải: $result');
      } else {
        errors.add('❌ Lỗi tải: $url');
      }
    } catch (e) {
      errors.add('⚠️ Lỗi ngoại lệ: $url - $e');
    }
  }

  return errors.isEmpty
      ? 'Tải ảnh thành công'
      : 'Có lỗi khi tải ảnh:\n${errors.join("\n")}';
}

final downloadImageProvider =
    FutureProvider.autoDispose.family<String, List<String>>((ref, listImage) {
  return downloadAllImages(listImage);
});