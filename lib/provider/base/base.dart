import 'package:flutter_riverpod/flutter_riverpod.dart';

class Base {
  String get baseUrl => 'api.connecthome.vn';
}

final baseProvider = Provider<Base>((ref) => Base());
