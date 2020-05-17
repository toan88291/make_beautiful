import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/features/auth/widget.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'dart:developer' as developer;

import 'sign_in_body_widget.dart';

class SignInPage extends StatefulWidget {
  final bool check;

  SignInPage({this.check = false});

  static const ROUTE_NAME = 'SignInPage';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static const TAG = 'SignInPage';

  @override
  Widget build(BuildContext context) {
    developer.log('', name: TAG);
    return Scaffold(
        appBar: AppHeaderWidget(
          leading: BackButton(),
          title: Text('Đăng nhập'),
          subTitle: Text(''),
          logo: AppIcons.icLogo,
        ),
        body: SignInBodyWidget(widget.check)
    );
  }
}
