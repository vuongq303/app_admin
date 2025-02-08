import 'package:app_admin/provider/can_ho_provider.dart';
import 'package:app_admin/provider/home_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/my_drop_down.dart';
import 'package:app_admin/views/home/widgets/widgets/can_ho_item.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loadmore/loadmore.dart';

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
      ref.read(canHoProvider.notifier).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final canHoNotifer = ref.watch(canHoProvider);
    final color = ref.read(stylesProvider);
    final menuNotifer = ref.watch(menuProvider);
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final List<String> listPhongNgu = ['1', '2', '3', '4', '5', '6'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: color.bgColor, size: 30),
                  ),
                );
                await Future.delayed(const Duration(milliseconds: 1000));
                if (!context.mounted) return;
                Navigator.pop(context);

                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(10),
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Tìm kiếm căn hộ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            menuNotifer.when(
                              data: (response) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      MyDropDown(
                                        onChange:
                                            homeNotifier.tenDuAnUpdateSelection,
                                        listMenu:
                                            ref.watch(listTenDuAnProvider),
                                        value: homeState.ten_du_an,
                                        title: 'Tên dự án',
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) =>
                                            homeNotifier.updateSelection(
                                                value, 'Tên tòa nhà'),
                                        listMenu: ref.watch(listToaNhaProvider),
                                        title: 'Tên tòa nhà',
                                        value: homeState.ten_toa_nha,
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) => homeNotifier
                                            .updateSelection(value, 'Nội thất'),
                                        listMenu:
                                            ref.watch(listNoiThatProvider),
                                        title: 'Nội thất',
                                        value: homeState.noi_that,
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) =>
                                            homeNotifier.updateSelection(
                                                value, 'Loại căn hộ'),
                                        listMenu:
                                            ref.watch(listLoaiCanHoProvider),
                                        title: 'Loại căn hộ',
                                        value: homeState.loai_can_ho,
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) =>
                                            homeNotifier.updateSelection(
                                                value, 'Hướng ban công'),
                                        listMenu:
                                            ref.watch(listHuongCanHoProvider),
                                        title: 'Hướng ban công',
                                        value: homeState.huong_can_ho,
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) =>
                                            homeNotifier.updateSelection(
                                                value, 'Số phòng ngủ'),
                                        listMenu: listPhongNgu,
                                        title: 'Số phòng ngủ',
                                        value: homeState.so_phong_ngu,
                                      ),
                                      const SizedBox(width: 10),
                                      MyDropDown(
                                        onChange: (value) =>
                                            homeNotifier.updateSelection(
                                                value, 'Trục căn hộ'),
                                        listMenu:
                                            ref.watch(listTrucCanHoProvider),
                                        title: 'Trục căn hộ',
                                        value: homeState.truc_can_ho,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              error: (error, stackTrace) => ErrorWidgets(),
                              loading: () =>
                                  LoadingAnimationWidget.fourRotatingDots(
                                color: color.bgColor,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          color.redOrange),
                                      foregroundColor:
                                          WidgetStatePropertyAll(color.whColor),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await homeNotifier.submitSelection();
                                    },
                                    child: const Text(
                                      'Tìm kiếm',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(color.bgColor),
                                      foregroundColor:
                                          WidgetStatePropertyAll(color.whColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      homeNotifier.resetSelection();
                                    },
                                    child: const Text(
                                      'Làm mới',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.filter_alt_outlined, size: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort, size: 25),
            )
          ],
        ),
        Expanded(
          child: canHoNotifer.when(
            data: (data) {
              return LoadMore(
                onLoadMore: () async {
                  ref.read(canHoProvider.notifier).loadMore();
                  return true;
                },
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => CanHoItem(
                    canHo: data[index],
                    index: index,
                  ),
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
          ),
        ),
      ],
    );
  }
}
