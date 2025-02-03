import 'package:app_admin/services/base.dart';
import 'package:app_admin/view_models/home_view_model.dart';
import 'package:app_admin/view_models/login_view_model.dart';
import 'package:app_admin/view_models/splash_view_model.dart';
import 'package:app_admin/styles/my_color.dart';
import 'package:app_admin/views/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MyColor()),
        Provider(create: (context) => LoginViewModel()),
        Provider(create: (context) => HomeViewModel()),
        Provider(create: (context) => SplashViewModel()),
        Provider(create: (context) => Base())
      ],
      child: MaterialApp.router(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
