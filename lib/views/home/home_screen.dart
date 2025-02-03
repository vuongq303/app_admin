import 'package:app_admin/view_models/home_view_model.dart';
import 'package:app_admin/views/home/widgets/my_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel viewModel;
  int _selectedIndex = 0;

  final List<Widget> _drawerScreens = [
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('About Screen', style: TextStyle(fontSize: 24))),
  ];

  final List<String> _drawerMenu = [
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
    'Item 6',
  ];

  final List<String> _listPhongNgu = ['1', '2', '3', '4', '5', '6'];

  @override
  void initState() {
    viewModel = context.read<HomeViewModel>();
    viewModel.loadDataSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = viewModel.color;
    final router = GoRouter.of(context);
    final hoTen = viewModel.hoTenSaved;
    final phanQuyen = viewModel.phanQuyenSaved;
    final tenDuAnSelected = viewModel.tenDuAnSelected;
    final tenToaNhaSelected = viewModel.tenToaNhaSelected;
    final noiThatSelected = viewModel.noiThatSelected;
    final loaiCanHoSelected = viewModel.loaiCanHoSelected;
    final huongBanCongSelected = viewModel.huongBanCongSelected;
    final soPhongNguSelected = viewModel.soPhongNguSelected;
    final trucCanHoSelected = viewModel.trucCanHoSelected;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.bgColor,
        foregroundColor: color.whColor,
        centerTitle: true,
        title: Text(
          _drawerMenu[_selectedIndex],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
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
                                  listMenu: listMenu,
                                  valueNotifier: tenDuAnSelected,
                                  title: 'Tên dự án',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: tenToaNhaSelected,
                                  listMenu: listMenu,
                                  title: 'Tên tòa nhà',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: noiThatSelected,
                                  listMenu: listMenu,
                                  title: 'Nội thất',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: loaiCanHoSelected,
                                  listMenu: listMenu,
                                  title: 'Loại căn hộ',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: huongBanCongSelected,
                                  listMenu: listMenu,
                                  title: 'Hướng ban công',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: soPhongNguSelected,
                                  listMenu: _listPhongNgu,
                                  title: 'Số phòng ngủ',
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  valueNotifier: trucCanHoSelected,
                                  listMenu: listMenu,
                                  title: 'Trục căn hộ',
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
                                  onPressed: () {
                                    setState(() {
                                      tenDuAnSelected.value = '';
                                      tenToaNhaSelected.value = '';
                                      noiThatSelected.value = '';
                                      loaiCanHoSelected.value = '';
                                      huongBanCongSelected.value = '';
                                      soPhongNguSelected.value = '';
                                      trucCanHoSelected.value = '';
                                    });
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
              accountName: ValueListenableBuilder(
                valueListenable: hoTen,
                builder: (context, value, child) => Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              accountEmail: ValueListenableBuilder(
                valueListenable: phanQuyen,
                builder: (context, value, child) => Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              currentAccountPicture: Icon(
                Icons.person,
                size: 60,
                color: color.grColor,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.business_outlined,
              ),
              title: const Text('Data nguồn'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.send,
              ),
              title: const Text('Căn hộ đã gửi'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.call_received,
              ),
              title: const Text('Căn hộ đã duyệt'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Đăng xuất'),
              onTap: () async {
                await viewModel.logout();
                router.go('/login');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _drawerScreens,
      ),
    );
  }
}
