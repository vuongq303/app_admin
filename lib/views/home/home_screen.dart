import 'package:app_admin/provider/home_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/my_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final color = ref.watch(stylesProvider);
    final router = GoRouter.of(context);
    homeNotifier.loadDataSaved();

    final List<String> listPhongNgu = ['1', '2', '3', '4', '5', '6'];

    final List<Widget> drawerScreens = [
      const Center(
        child: Text('Home Screen', style: TextStyle(fontSize: 24)),
      ),
      const Center(
        child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
      ),
      const Center(
        child: Text('About Screen', style: TextStyle(fontSize: 24)),
      ),
    ];

    final List<String> drawerMenu = [
      'Data nguồn',
      'Căn hộ đã gửi',
      'Căn hộ đã duyệt'
    ];

    final List<String> listMenu = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 8',
      'Item 7',
      'Item 6'
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  value: homeState.tenDuAn,
                                  title: 'Tên dự án',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  title: 'Tên tòa nhà',
                                  value: homeState.tenToaNha,
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  title: 'Nội thất',
                                  value: homeState.noiThat,
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  title: 'Loại căn hộ',
                                  value: homeState.loaiCanHo,
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  title: 'Hướng ban công',
                                  value: homeState.huongBanCong,
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listPhongNgu,
                                  title: 'Số phòng ngủ',
                                  value: homeState.soPhongNgu,
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  homeProvider: homeNotifier,
                                  listMenu: listMenu,
                                  title: 'Trục căn hộ',
                                  value: homeState.trucCanHo,
                                ),
                              ],
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                                  onPressed: () {},
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
