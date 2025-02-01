import 'package:app_admin/view_models/home_view_model.dart';
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
  String? selectedValue;

  final List<Widget> _drawerScreens = [
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('About Screen', style: TextStyle(fontSize: 24))),
  ];

  final List<String> _drawerTitle = [
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
          _drawerTitle[_selectedIndex],
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
