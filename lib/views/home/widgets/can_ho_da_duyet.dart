import 'package:app_admin/provider/can_ho_da_duyet_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/widgets/can_ho_da_gui_item.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CanHoDaDuyet extends ConsumerStatefulWidget {
  const CanHoDaDuyet({super.key});

  @override
  ConsumerState<CanHoDaDuyet> createState() => _CanHoDaDuyetState();
}

class _CanHoDaDuyetState extends ConsumerState<CanHoDaDuyet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(canHoDaDuyetProvider.notifier).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final canHoNotifer = ref.watch(canHoDaDuyetProvider);
    final color = ref.read(stylesProvider);

    return canHoNotifer.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => CanHoDaGuiItem(
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
