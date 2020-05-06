import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/features/auth/widget.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'dart:developer' as developer;
import 'sign_up_body_widget.dart';

class SignUpPage extends StatefulWidget {
  static const ROUTE_NAME = 'SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const TAG = 'SignUpPage';

  @override
  Widget build(BuildContext context) {
    developer.log('', name: TAG);
    return Scaffold(
        appBar: AppHeaderWidget(
          leading: BackButton(),
          title: Text('Đăng ký'),
          subTitle: Text('Để có thêm nhiều tiện ích'),
          logo: AppIcons.icLogo,
        ),
        body: SignUpBodyWidget()
    );
  }
}
