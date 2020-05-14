import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/utils/utils.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:provider/provider.dart';

class ForgotPasswordBody extends StatefulWidget {
  @override
  _ForgotPasswordBodyState createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  AppBloc _appBloc;

  SignInUser user;

  GlobalKey<FormState> _keyForm = GlobalKey();

  String pass;

  String rePass;

  bool isError = false;

  bool obscureText = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    user = _appBloc.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 20, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Mật khẩu mới',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: FormInputWidget(
                  '******',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  validator: (value) {
                    if (!ValidateUtils.isPassword(value)) {
                      return 'Mật khẩu ít 6 kí tự và có một ký tự số và kí tự đặc biệt ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    pass = value.trim();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nhập lại mật khẩu mới',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: FormInputWidget(
                  '******',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  validator: (value) {
                    if (!ValidateUtils.isPassword(value)) {
                      return 'Mật khẩu ít 6 kí tự và có một ký tự số và kí tự đặc biệt ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    rePass = value.trim();
                  },
                ),
              ),

              ButtonClickWidget(
                'Đổi mật khẩu',
                false,
                onPressed: _handleSignUpTap,
              ),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                      'Mật khẩu không trùng nhau',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.red
                      ),
                  ),
                ),
                visible: isError,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUpTap() {

    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();
      if (pass == rePass) {
        setState(() {
          isError = false;
        });
        showDialogProgressLoading<bool>(context, _appBloc.forgotPass(
          SignInUser(
            user.avatar,
            user.fullname,
            pass,
            user.role,
            user.save_post,
            user.username,
          )..docId = user.docId
        )).then((value) {
          if (value) {
            Navigator.of(context).pushReplacementNamed('main');
          }
        });

      } else {
        setState(() {
          isError = true;
        });
      }
    }
  }

}