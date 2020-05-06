import 'dart:developer' as developer;
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/data/repository/category_repository.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends ChangeNotifier {
  static const TAG = 'CategoryBloc';

  CategoryRepository categoryRepository;

  SignInUser currentUser;

  String idUser;

  List<Post> dataStorage = [];

  Result<List<Category>> categoryData = Result.value(null);

  AppBloc({this.categoryRepository}) {
    getCategory();
    getIdUser();
    categoryRepository.firebaseUser.addListener(() {

    });
  }

  void getCategory() {
    categoryRepository.getCategory().then((value) {
      categoryData = value;
      notifyListeners();
    });
  }

  void getIdUser() {
    SharedPreferences.getInstance().then((value) {
      idUser = value.getString(TOKEN);
      if (idUser != null) {
        getCurrentUser(idUser);
      }
    });
    notifyListeners();
  }

  Future<void> getCurrentUser(String id) async {
    currentUser = await categoryRepository.getUser(id);
    await getStoragePost(currentUser);
    notifyListeners();
  }

  Future<void> setCurrentUser(SignInUser user) async {
    currentUser = user;
    SharedPreferences.getInstance().then((value) {
      value.setString(TOKEN,currentUser.docId);
    });
    await getStoragePost(user);
    notifyListeners();
  }

  Future<Result<List<Post>>> getNewPost() {
    return categoryRepository.getNewPost();
  }

  Future<void> getStoragePost(SignInUser user) async{
    user.save_post.forEach((element) {
      debugPrint('getStoragePost id : $element');
      categoryRepository.getStoragePost(element).then((value) {
        dataStorage.add(value.asValue.value);
        notifyListeners();
      });
    });
  }

  Future<bool> insertUser(SignUpUser data){
    return categoryRepository.insertUser(data);
  }

  Future<bool> login(String user, String pass) async {
    List<SignInUser> result = await categoryRepository.login(user, pass);
    if (result != null) {
      setCurrentUser(result[0]);
    }
    return result != null;
  }

  Future<SignInUser> getUser(String id) async{
    SignInUser signInUser = await categoryRepository.getUser(id);
    return signInUser;
  }

}