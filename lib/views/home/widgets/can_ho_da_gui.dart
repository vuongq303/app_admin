import 'package:app_admin/provider/can_ho_da_gui_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/widgets/can_ho_da_gui_item.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CanHoDaGui extends ConsumerStatefulWidget {
  const CanHoDaGui({super.key});

  @override
  ConsumerState<CanHoDaGui> createState() => _CanHoDaGuiState();
}

class _CanHoDaGuiState extends ConsumerState<CanHoDaGui> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(canHoDaGuiProvider.notifier).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final canHoNotifer = ref.watch(canHoDaGuiProvider);
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
