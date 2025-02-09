import 'package:flutter_riverpod/flutter_riverpod.dart';

final middleProvider = StateProvider<bool>((ref) => false);

final isHaveData = StateProvider<bool>((ref) => true);
