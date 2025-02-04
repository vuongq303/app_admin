import 'package:app_admin/provider/splash_provider.dart';
import 'package:app_admin/views/home/home_screen.dart';
import 'package:app_admin/views/login/login_screen.dart';
import 'package:app_admin/widgets/error_widgets.dart';
import 'package:app_admin/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(splashProvider.notifier).authLogin();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(splashProvider);

    return Scaffold(
      body: provider.when(
        data: (status) {
          if (status) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
        error: (error, stackTrace) => ErrorWidgets(),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
