import 'package:app_admin/provider/can_ho_provider.dart';
import 'package:app_admin/provider/home_provider.dart';
import 'package:app_admin/provider/middleware/middle_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/my_drop_down.dart';
import 'package:app_admin/views/home/widgets/widgets/can_ho_item.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
    final canHoState = ref.watch(canHoProvider);
    final canHoNotifer = ref.watch(canHoProvider.notifier);
    final color = ref.read(stylesProvider);
    final menuNotifer = ref.watch(menuProvider);
    final homeState = ref.read(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final isSearchState = ref.read(middleProvider.notifier);
    final isHaveDataState = ref.read(isHaveData.notifier);
    final List<String> listPhongNgu = ['1', '2', '3', '4', '5', '6'];
    final List<String> listGiaCanHo = [
      "Giá bán tăng dần",
      "Giá bán giảm dần",
      "Giá thuê tăng dần",
      "Giá thuê giảm dần",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
                        Expanded(
                          child: menuNotifer.when(
                            data: (response) {
                              return SingleChildScrollView(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tên dự án',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: homeNotifier
                                              .tenDuAnUpdateSelection,
                                          listMenu:
                                              ref.watch(listTenDuAnProvider),
                                          value: homeState.ten_du_an,
                                          title: 'Tên dự án',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tên tòa nhà',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Tên tòa nhà'),
                                          listMenu:
                                              ref.watch(listToaNhaProvider),
                                          title: 'Tên tòa nhà',
                                          value: homeState.ten_toa_nha,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nội thất',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Nội thất'),
                                          listMenu:
                                              ref.watch(listNoiThatProvider),
                                          title: 'Nội thất',
                                          value: homeState.loai_noi_that,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Loại căn hộ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Loại căn hộ'),
                                          listMenu:
                                              ref.watch(listLoaiCanHoProvider),
                                          title: 'Loại căn hộ',
                                          value: homeState.loai_can_ho,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Hướng ban công',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Hướng ban công'),
                                          listMenu:
                                              ref.watch(listHuongCanHoProvider),
                                          title: 'Hướng ban công',
                                          value: homeState.huong_can_ho,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Số phòng ngủ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Số phòng ngủ'),
                                          listMenu: listPhongNgu,
                                          title: 'Số phòng ngủ',
                                          value: homeState.so_phong_ngu,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Trục căn hộ',
                                          style: TextStyle(fontSize: 16),
                                        ),
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
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Lọc giá',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        MyDropDown(
                                          onChange: (value) =>
                                              homeNotifier.updateSelection(
                                                  value, 'Lọc giá'),
                                          listMenu: listGiaCanHo,
                                          title: 'Lọc giá căn hộ',
                                          value: homeState.truc_can_ho,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            onChanged: (value) =>
                                                homeNotifier.updateSelection(
                                                    value, 'Giá từ'),
                                            inputFormatters: [
                                              ThousandsSeparatorInputFormatter()
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Giá từ",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextField(
                                            onChanged: (value) =>
                                                homeNotifier.updateSelection(
                                                    value, 'Giá đến'),
                                            inputFormatters: [
                                              ThousandsSeparatorInputFormatter()
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Đến giá",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
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
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(color.redOrange),
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
        Expanded(
          child: canHoState.when(
            data: (data) {
              return LoadMore(
                onLoadMore: () async {
                  if (isHaveDataState.state) {
                    if (isSearchState.state) {
                      print('Search');
                      homeNotifier.loadMore();
                      return false;
                    }
                    canHoNotifer.loadMore();
                  }
                  return false;
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###", "en_US");
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    String newText = newValue.text.replaceAll(',', '');

    int? value = int.tryParse(newText);
    if (value == null) return oldValue;

    String formattedText = _formatter.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
