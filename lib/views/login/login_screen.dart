import 'package:app_admin/view_models/login_view_model.dart';
import 'package:app_admin/views/login/widgets/button_login.dart';
import 'package:app_admin/views/login/widgets/input_login.dart';
import 'package:app_admin/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSaveAccount = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    final color = viewModel.color;
    final maxWidth = MediaQuery.of(context).size.width;
    final router = GoRouter.of(context);

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
                    child: Image.network(
                      'https://connecthome.vn/source/connect_home.png',
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputLogin(
                        color: color,
                        isSecured: false,
                        title: 'Tài khoản',
                        onSaved: viewModel.onSaveUsernameInputForm,
                        onValidator: viewModel.onVaidatorUsernameInputForm,
                      ),
                      const SizedBox(height: 15),
                      InputLogin(
                        color: color,
                        isSecured: true,
                        title: 'Mật khẩu',
                        onSaved: viewModel.onSavePasswordInputForm,
                        onValidator: viewModel.onVaidatorPasswordInputForm,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              side: BorderSide(color: color.whColor, width: 2),
                              checkColor: color.whColor,
                              activeColor: color.grColor,
                              value: isSaveAccount,
                              onChanged: (value) {
                                setState(() {
                                  isSaveAccount = !isSaveAccount;
                                });
                              },
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
                      ButtonLogin(
                        maxWidth: maxWidth,
                        onClick: () async {
                          FocusManager.instance.primaryFocus!.unfocus();
                          showLoading(context, color.whColor);
                          await viewModel.onSubmitFormLogin(
                              formKey, router, context, isSaveAccount);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        title: 'Đăng nhập',
                        textColor: Colors.white,
                        bgColor: color.redOrange,
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
