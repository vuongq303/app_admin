import 'package:app_admin/provider/can_ho_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/widgets/can_ho_item.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CanHo extends ConsumerStatefulWidget {
  const CanHo({super.key});

  @override
  ConsumerState<CanHo> createState() => _CanHoState();
}

class _CanHoState extends ConsumerState<CanHo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(canHoProvider.notifier).getData(50, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final canHoNotifer = ref.watch(canHoProvider);
    final color = ref.read(stylesProvider);
    return canHoNotifer.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => CanHoItem(
            canHo: data[index],
            index: index,
          ),
        );
      },
      error: (error, stackTrace) => const ErrorWidgets(),
      loading: () => Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: color.bgColor,
          size: 50,
        ),
      ),
    );
  }
}
