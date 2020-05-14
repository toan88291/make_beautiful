import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/features/auth/widget.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';

import 'change_info_body.dart';

class ChangeInfoPage extends StatefulWidget {
  final SignInUser user;

  ChangeInfoPage(this.user);

  @override
  _ChangeInfoPageState createState() => _ChangeInfoPageState();
}

class _ChangeInfoPageState extends State<ChangeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeaderWidget(
          leading: BackButton(),
          title: Text('Đổi thông tin'),
          subTitle: Text(''),
          logo: AppIcons.icLogo,
        ),
        body: ChangeInfoBody(widget.user)
    );
  }
}