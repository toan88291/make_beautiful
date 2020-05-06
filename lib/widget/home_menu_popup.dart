import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/features/auth/forgot_pass/forgot_password_body.dart';
import 'package:flutter_app_make_beautiful/features/auth/forgot_pass/forgot_password_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeMenuPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceOut,
      insetAnimationDuration: Duration(milliseconds: 500),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_Header(), _Body(), _Footer()],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              Provider.of<AppBloc>(context).currentUser.avatar,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              frameBuilder: (BuildContext context, Widget child, int frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return frame == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[100]),
                        ),
                      )
                    : Image.network(
                        Provider.of<AppBloc>(context).currentUser.avatar,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Provider.of<AppBloc>(context).currentUser.fullname,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  Provider.of<AppBloc>(context).currentUser.role
                      ? 'Admin'
                      : 'Member',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: Divider.createBorderSide(context),
        bottom: Divider.createBorderSide(context, width: 1),
      )),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: <Widget>[
          ListTile(
            isThreeLine: false,
            dense: false,
            leading: Icon(Icons.info),
            title: Text(
              'Đổi thông tin',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            isThreeLine: false,
            dense: false,
            leading: Icon(Icons.https),
            title: Text(
              'Đổi mật khẩu',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ForgotPasswordPage();
              }));
            },
          ),
          ListTile(
            isThreeLine: false,
            dense: false,
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Đăng xuất',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Provider.of<AppBloc>(context, listen: false).logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      alignment: Alignment.center,
      child: Text(
        'Privacy Policy · Terms of Service',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
