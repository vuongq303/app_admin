import 'package:flutter_riverpod/flutter_riverpod.dart';

final middleProvider = StateProvider<bool>((ref) => false);

final countCanHo = StateProvider<int>(((ref) => 0));
final totalCanHo = StateProvider<int>((ref) => 0);
