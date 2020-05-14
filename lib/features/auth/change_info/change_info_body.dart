import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'package:flutter_app_make_beautiful/widget/form_input_widget.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeInfoBody extends StatefulWidget {
  final SignInUser user;

  ChangeInfoBody(this.user);

  @override
  _ChangeInfoBodyState createState() => _ChangeInfoBodyState();
}

class _ChangeInfoBodyState extends State<ChangeInfoBody> {
  AppBloc _appBloc;

  GlobalKey<FormState> _keyForm = GlobalKey();

  String fullname;

  String username;

  String _uploadedURL;

  bool obscureText = true;

  bool isShowEmail = false;

  bool errorText = false;

  bool isUpload = false;

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
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.user.avatar))),
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
                  '',
                  initialValue: widget.user.fullname,
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
                  '',
                  initialValue: widget.user.username,
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
                'Đổi thông tin',
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
      if (_image == null) {
        _appBloc.changeInfo(SignInUser(
          widget.user.avatar,
          fullname,
          widget.user.password,
          widget.user.role,
          widget.user.save_post,
          username,
        )..docId = widget.user.docId)
            .then((value) {
          if (value) {
            isUpload = false;
            Navigator.of(context).pushReplacementNamed('main');
          } else {
            setState(() {
              errorText = true;
            });
          }
        });
      } else {
        uploadFile();
      }
    }
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {
    setState(() {
      isUpload = true;
    });
    Random random = new Random();
    int randomNumber = random.nextInt(100000000) + 10;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('avatar/${Path.basename(randomNumber.toString() + '.png')}');

    StorageUploadTask uploadTask = storageReference.putFile(_image);
    uploadTask.onComplete.whenComplete(() {
      storageReference.getDownloadURL().then((fileURL) {
//        FirebaseStorage.instance
//            .ref()
//            .child('avatar/'+widget.user.avatar
//                .replaceAll(
//                    RegExp(
//                        r'https://firebasestorage.googleapis.com/v0/b/beautiful-care.appspot.com/o/avatar%2F'),
//                    '')
//                .split('?')[0])
//            .delete();
        _appBloc.changeInfo(SignInUser(
          fileURL,
          fullname,
          widget.user.password,
          widget.user.role,
          widget.user.save_post,
          username,
        )..docId = widget.user.docId)
            .then((value) {
          if (value) {
            isUpload = false;
            _appBloc.getCurrentUser(widget.user.docId);
            Navigator.of(context).pushReplacementNamed('main');
          } else {
            setState(() {
              errorText = true;
            });
          }
        });
      });
    });
  }
}
