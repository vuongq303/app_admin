import 'package:app_admin/view_models/splash_view_model.dart';
import 'package:app_admin/styles/my_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    authLogin(context);
  }

  Future<void> authLogin(BuildContext context) async {
    final viewModel = context.read<SplashViewModel>();
    final router = GoRouter.of(context);
    final bool status = await viewModel.authLogin(context);
    if (status) {
      router.pushReplacement('/home');
      return;
    }
    router.pushReplacement('/login');
  }

  @override
  Widget build(BuildContext context) {
    final color = context.read<MyColor>();

    return Scaffold(
      body: Container(
        color: color.bgColor,
        child: Column(
          children: [
            Image.asset('assets/images/connect_home.png'),
            LoadingAnimationWidget.fourRotatingDots(
              color: color.whColor,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
