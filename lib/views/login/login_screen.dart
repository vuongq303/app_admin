import 'package:app_admin/provider/login_provider.dart';
import 'package:app_admin/provider/styles/styles.dart';
import 'package:app_admin/views/login/widgets/button_login.dart';
import 'package:app_admin/views/login/widgets/input_login.dart';
import 'package:app_admin/widgets/condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxWidth = MediaQuery.of(context).size.width;
    final router = GoRouter.of(context);
    final loginState = ref.watch(loginProvider);
    final color = ref.watch(stylesProvider);
    final loginNotifer = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: color.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: Align(
                    widthFactor: 1,
                    heightFactor: 0.5,
                    child: Image.asset(
                      'assets/images/connect_home.png',
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputLogin(
                        color: color,
                        isSecured: false,
                        title: 'Tài khoản',
                        onSaved: loginNotifer.updateUsername,
                        onValidator: loginNotifer.validateUsername,
                      ),
                      const SizedBox(height: 15),
                      InputLogin(
                        color: color,
                        isSecured: true,
                        title: 'Mật khẩu',
                        onSaved: loginNotifer.updatePassword,
                        onValidator: loginNotifer.validatePassword,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              side: BorderSide(color: color.whColor, width: 2),
                              checkColor: color.whColor,
                              activeColor: color.grColor,
                              value: loginState.isSaveAccount,
                              onChanged: loginNotifer.toggleSaveAccount,
                            ),
                          ),
                          Text(
                            'Lưu tài khoản?',
                            style: TextStyle(
                              color: color.whColor,
                            ),
                          )
                        ],
                      ),
                      ConditionWidget(
                        widgetTrue: LoadingAnimationWidget.fourRotatingDots(
                          color: color.whColor,
                          size: 30,
                        ),
                        widgetFalse: ButtonLogin(
                          maxWidth: maxWidth,
                          onClick: () async {
                            await loginNotifer.login(_formKey, router, context);
                          },
                          title: 'Đăng nhập',
                          textColor: Colors.white,
                          bgColor: color.redOrange,
                        ),
                        condition: loginState.isLoading,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Liên hệ ngay quản trị viên',
                  style: TextStyle(
                    color: color.whColor,
                  ),
                ),
                Text(
                  'để được cấp tài khoản!',
                  style: TextStyle(
                    color: color.whColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
