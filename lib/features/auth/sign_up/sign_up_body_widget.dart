import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_in/sign_in_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'package:flutter_app_make_beautiful/utils/utils.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
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

  String _uploadedURL;

  String password;

  bool obscureText = true;

  bool isShowEmail = false;

  bool errorText = false;

  File _image;

  bool isUpload = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
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
              _image != null
                  ? Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: FileImage(
                            _image,
                          ))),
                    )
                  : Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                            AppIcons.icAvatar,
                          ))),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Add Profile Photo',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold),
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
              Visibility(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Tên đăng nhập đã tồn tại',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
                visible: errorText,
              ),
              ButtonClickWidget(
                'Đăng kí',
                isUpload,
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
      setState(() {
        errorText = false;
        isUpload = true;
      });
      _appBloc.isCheckUser(username)
          .then((value) {
        if (value) {
          debugPrint('user da ton tai ');
          setState(() {
            errorText = true;
            isUpload = false;
          });
        } else {
          if (_image == null) {
            showDialogProgressLoading(
                context,
                _appBloc.insertUser(SignUpUser(
                  IMAGE,
                  fullname,
                  password,
                  false,
                  [],
                  username,
                ))).then((value) {
              if (value) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return SignInPage();
                }));
              }
            });
          } else {
            uploadFile();
          }
        }
      });
    }
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void uploadFile() {
    Random random = new Random();
    int randomNumber = random.nextInt(100000000) +10 ;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('avatar/${Path.basename(randomNumber.toString()+'.png')}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    uploadTask.onComplete.whenComplete((){
      developer.log('uploadFile', name: TAG);
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedURL = fileURL;
          developer.log('uploadFile url : $_uploadedURL', name: TAG);
          _appBloc.insertUser(SignUpUser(
            _uploadedURL,
            fullname,
            password,
            false,
            [],
            username,
          )).then((value) {
            isUpload = false;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SignInPage();
            }));
          });
        });
      }).catchError((err){
        developer.log('uploadFile error $err', name: TAG);
      });
    });

  }
}
