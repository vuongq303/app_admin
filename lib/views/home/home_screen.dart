import 'package:app_admin/provider/home_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/home/widgets/can_ho.dart';
import 'package:app_admin/views/home/widgets/can_ho_da_duyet.dart';
import 'package:app_admin/views/home/widgets/can_ho_da_gui.dart';
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

    final List<Widget> drawerScreens = [
      const CanHo(),
      const CanHoDaGui(),
      const CanHoDaDuyet(),
    ];

    final List<String> drawerMenu = [
      'Data nguồn',
      'Căn hộ đã yêu cầu',
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
              title: Text(drawerMenu[0]),
              onTap: () {
                homeNotifier.updateState(selectedIndex: 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: Text(drawerMenu[1]),
              onTap: () {
                homeNotifier.updateState(selectedIndex: 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.call_received),
              title: Text(drawerMenu[2]),
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
