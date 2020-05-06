import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_in/sign_in_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/utils.dart';
import 'dart:developer' as developer;

import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpBodyWidget extends StatefulWidget {
  @override
  _SignUpBodyWidgetState createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  static const TAG = 'SignUpBodyWidget';

  AppBloc _appBloc;

  GlobalKey<FormState> _keyForm = GlobalKey();

  ValueChanged<String> validateFun;

  String fullname;

  String username;

  String password;

  bool obscureText = true;

  bool isShowEmail = false;

  String errorText;

  File _image;

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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: InkWell(
                  onTap: () {
                    getPicture();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Add Profile Photo',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Họ và tên',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: FormInputWidget(
                  'Lê Mạnh Toàn',
                  prefixIcon: Icon(
                    Icons.person_pin,
                    color: Theme.of(context).primaryColor,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nhập họ và tên đầy đủ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fullname = value.trim();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tên đăng nhập',
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
                  'toan882911',
                  prefixIcon: Icon(
                    Icons.verified_user,
                    color: Theme.of(context).primaryColor,
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
                padding: EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mật khẩu',
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
                  obscureText: obscureText,
                  validator: (value) {
                    if (!ValidateUtils.isPassword(value)) {
                      return 'Mật khẩu ít 6 kí tự và có một ký tự số và kí tự đặc biệt ';
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
              ButtonClickWidget(
                'Đăng kí',
                onPressed: _handleSignUpTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUpTap() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();
      showDialogProgressLoading(
          context,
          _appBloc
              .insertUser(SignUpUser(
            IMAGE,
            fullname,
            password,
            false,
            [],
            username,
          ))
      ).then((value) {
        if (value) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return SignInPage();
          }));
        }
      });
    }
  }

  Future<void> getPicture() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: new Text("Pick image from"),
            actions: <Widget>[
              FlatButton(
                child: new Text("GALLERY",style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  getImageGallery();
                },
              ),
              FlatButton(
                child: new Text("CAMERA",style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  getImageCamera();
                },
              ),
            ],
          );
        });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      developer.log('getImageGallery $_image', name: TAG);
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

}
