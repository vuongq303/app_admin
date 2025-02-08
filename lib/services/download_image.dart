// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_downloader/image_downloader.dart';

// Future<String> downloadAllImages(List<String> imageUrls) async {
//   List<String> errors = [];

//   for (String url in imageUrls) {
//     try {
//       var result = await ImageDownloader.downloadImage(url);

//       print('✅ Đã tải: $result');
//     } catch (e) {
//       errors.add('⚠️ Lỗi ngoại lệ: $url - $e');
//     }
//   }

//   return errors.isEmpty
//       ? 'Tải ảnh thành công'
//       : 'Có lỗi khi tải ảnh:\n${errors.join("\n")}';
// }

// final downloadImageProvider =
//     FutureProvider.autoDispose.family<String, List<String>>((ref, listImage) {
//   return downloadAllImages(listImage);
// });
