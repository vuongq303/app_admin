import 'package:app_admin/provider/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(stylesProvider);

    return Container(
      color: color.bgColor,
      child: Column(
        children: [
          Image.asset('assets/images/connect_home.png'),
          LoadingAnimationWidget.fourRotatingDots(
            color: color.whColor,
            size: 50,
          ),
        ],
      ),
    );
  }
}
