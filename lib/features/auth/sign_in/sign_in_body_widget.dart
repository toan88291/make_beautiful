import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_up/sign_up_page.dart';
import 'package:flutter_app_make_beautiful/features/main_page.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:provider/provider.dart';

class SignInBodyWidget extends StatefulWidget {
  @override
  _SignInBodyWidgetState createState() => _SignInBodyWidgetState();
}

class _SignInBodyWidgetState extends State<SignInBodyWidget> {
  static const TAG = 'SignInBodyWidget';

  AppBloc _appBloc;

  GlobalKey<FormState> _keyForm = GlobalKey();

  ValueChanged<String> validateFun;

  String username;

  String password;

  bool obscureText = true;

  bool isShowEmail = false;

  bool errorText = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
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
                padding: EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tên đăng nhập',
                  textAlign: TextAlign.left,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: FormInputWidget(
                  'toan882911',
                  prefixIcon: Icon(
                    Icons.verified_user,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập tên đăng nhập đầy đủ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    username = value.trim();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mật khẩu',
                  textAlign: TextAlign.left,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: FormInputWidget(
                  '******',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  obscureText: obscureText,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Mật khẩu không được để trống !';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  onSaved: (value) {
                    password = value.trim();
                  },
                ),
              ),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Đăng nhập thất bại! \n Sai tên đăng nhập hoặc nhật khẩu',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
                visible: errorText,
              ),
              ButtonClickWidget(
                'Đăng nhập',
                false,
                onPressed: _handleSignInTap,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    return SignUpPage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Đăng kí tài khoản',
                    textAlign: TextAlign.left,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignInTap() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();
      setState(() {
        errorText = false;
      });
      showDialogProgressLoading(context, _appBloc.login(username, password))
          .then((value) {
            if (value) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return MainPage();
              }));
            } else {
              setState(() {
                errorText = true;
              });
            }
      });
    }
  }
}
