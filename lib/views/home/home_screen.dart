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
  int _selectedIndex = 0;
  late HomeViewModel viewModel;
  String? tenDuAnSelected;
  String? tenToaNhaSelected;
  String? noiThatSelected;
  String? loaiCanHoSelected;
  String? huongBanCongSelected;
  String? soPhongNguSelected;
  String? trucCanHoSelected;

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
    final hoTen = viewModel.hoTenSaved;
    final phanQuyen = viewModel.phanQuyenSaved;
    final router = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
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
            icon: Icon(Icons.menu),
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
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyDropDown(
                                  listMenu: listMenu,
                                  selectedValue: tenDuAnSelected,
                                  title: 'Tên dự án',
                                  onChange: (String? value) {
                                    setState(() {
                                      tenDuAnSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: tenToaNhaSelected,
                                  listMenu: listMenu,
                                  title: 'Tên tòa nhà',
                                  onChange: (String? value) {
                                    setState(() {
                                      tenToaNhaSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: noiThatSelected,
                                  listMenu: listMenu,
                                  title: 'Nội thất',
                                  onChange: (String? value) {
                                    setState(() {
                                      noiThatSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: loaiCanHoSelected,
                                  listMenu: listMenu,
                                  title: 'Loại căn hộ',
                                  onChange: (String? value) {
                                    setState(() {
                                      tenDuAnSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: huongBanCongSelected,
                                  listMenu: listMenu,
                                  title: 'Hướng ban công',
                                  onChange: (String? value) {
                                    setState(() {
                                      huongBanCongSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: soPhongNguSelected,
                                  listMenu: _listPhongNgu,
                                  title: 'Số phòng ngủ',
                                  onChange: (String? value) {
                                    setState(() {
                                      soPhongNguSelected = value;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyDropDown(
                                  selectedValue: trucCanHoSelected,
                                  listMenu: listMenu,
                                  title: 'Trục căn hộ',
                                  onChange: (String? value) {
                                    setState(() {
                                      trucCanHoSelected = value;
                                    });
                                  },
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
                                  onPressed: () {},
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
            icon: Icon(Icons.filter_alt_outlined),
          ),
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
