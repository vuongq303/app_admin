import 'package:app_admin/provider/home_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/can_ho.dart';
import 'package:app_admin/views/home/widgets/can_ho_da_duyet.dart';
import 'package:app_admin/views/home/widgets/can_ho_da_gui.dart';
import 'package:app_admin/views/home/widgets/my_drop_down.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final menuNotifer = ref.watch(menuProvider);
    final color = ref.watch(stylesProvider);
    final router = GoRouter.of(context);
    homeNotifier.loadDataSaved();

    final List<String> listPhongNgu = ['1', '2', '3', '4', '5', '6'];

    final List<Widget> drawerScreens = [
      const CanHo(),
      const CanHoDaGui(),
      const CanHoDaDuyet(),
    ];

    final List<String> drawerMenu = [
      'Data nguồn',
      'Căn hộ đã gửi',
      'Căn hộ đã duyệt'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.bgColor,
        foregroundColor: color.whColor,
        centerTitle: true,
        title: Text(
          drawerMenu[homeState.selectedIndex],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, size: 25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
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
                                      listMenu: ref.watch(listTenDuAnProvider),
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
                                      listMenu: ref.watch(listNoiThatProvider),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort, size: 25),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: color.bgColor),
              accountName: Text(
                homeState.hoTen,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(homeState.phanQuyen,
                  style: const TextStyle(fontSize: 16)),
              currentAccountPicture:
                  Icon(Icons.person, size: 60, color: color.grColor),
            ),
            ListTile(
              leading: const Icon(Icons.business_outlined),
              title: const Text('Data nguồn'),
              onTap: () {
                homeNotifier.updateState(selectedIndex: 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Căn hộ đã gửi'),
              onTap: () {
                homeNotifier.updateState(selectedIndex: 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.call_received),
              title: const Text('Căn hộ đã duyệt'),
              onTap: () {
                homeNotifier.updateState(selectedIndex: 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Đăng xuất'),
              onTap: () async {
                await homeNotifier.logout();
                router.go('/login');
              },
            ),
          ],
        ),
      ),
      body: drawerScreens[homeState.selectedIndex],
    );
  }
}
