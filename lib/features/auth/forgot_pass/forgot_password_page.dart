import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/features/auth/widget.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';

import 'forgot_password_body.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeaderWidget(
          leading: BackButton(),
          title: Text('Đổi mật khẩu'),
          subTitle: Text(''),
          logo: AppIcons.icLogo,
        ),
        body: ForgotPasswordBody()
    );
  }
}