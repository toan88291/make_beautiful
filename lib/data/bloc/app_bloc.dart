import 'dart:developer' as developer;
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sub_category.dart';
import 'package:flutter_app_make_beautiful/data/repository/app_repository.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends ChangeNotifier {
  static const TAG = 'CategoryBloc';

  AppRepository appRepository;

  SignInUser currentUser;

  String idUser;

  List<Post> dataStorage = [];

  List<Post> dataHairBeauty = [];

  List<Post> dataMakeUp = [];

  List<Post> dataSport = [];

  List<Post> dataSkinBeauty = [];

  List<Post> dataWearBeauty = [];

  Result<List<Category>> categoryData = Result.value(null);

  AppBloc({this.appRepository}) {
    getCategory();
    getIdUser();
    getPostHair();
    getMakeUp();
    getSport();
    getSkinBeauty();
    getWearBeauty();
  }

  void getCategory() {
    appRepository.getCategory().then((value) {
      categoryData = value;
      notifyListeners();
    });
  }

  Future<void> getIdUser() async {
    SharedPreferences.getInstance().then((value) {
      idUser = value.getString(TOKEN);
      if (idUser != null) {
        getCurrentUser(idUser);
      }
    });
    notifyListeners();
  }

  Future<void> getCurrentUser(String id) async {
    currentUser = await appRepository.getUser(id);
    getStoragePost(currentUser);
    notifyListeners();
  }

  Future<void> setCurrentUser(SignInUser user) async {
    currentUser = user;
    debugPrint('1');
    SharedPreferences.getInstance().then((value) {
      value.setString(TOKEN,currentUser.docId);
    });
    debugPrint('2');
    notifyListeners();
  }

  Future<Result<List<Post>>> getNewPost() {
    return appRepository.getNewPost();
  }

  Future<void> getStoragePost(SignInUser user) async{
    dataStorage = [];
    user.save_post?.forEach((element) {
      debugPrint('getStoragePost id : $element');
      appRepository.getStoragePost(element).then((value) {
        dataStorage.add(value.asValue.value);
        notifyListeners();
      });
    });
  }

  Future<bool> insertUser(SignUpUser data){
    return appRepository.insertUser(data);
  }

  Future<bool> login(String user, String pass) async {
    List<SignInUser> result = await appRepository.login(user, pass);
    if (result.length > 0) {
      setCurrentUser(result[0]);
    }
    return result.length > 0;
  }

  Future<SignInUser> getUser(String id) async{
    SignInUser signInUser = await appRepository.getUser(id);
    return signInUser;
  }

  void logout() {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
    dataStorage = [];
    idUser = null;
    currentUser = null;
    notifyListeners();
  }

  Future<bool> forgotPass(SignInUser user) {
    return appRepository.forgotPass(user);
  }

  Future<bool> isCheckUser(String user) async {
    return appRepository.isCheckUser(user);
  }

  Future<bool> changeInfo(SignInUser user) async {
    bool result = await appRepository.changeInfo(user);
    if (result) {
      notifyListeners();
    }
    return appRepository.changeInfo(user);
  }

  Future<bool> isLiked(List<String> like, String docId) async {
    return appRepository.isLiked(like,docId);
  }

  Future<Result<List<SubCategory>>> getSubCategory(String id) async {
    return appRepository.getSubCategory(id);
  }

  Future<List<Post>> getPost(String id, TypePost typePost) async {
    return appRepository.getPost(id, typePost);
  }

  Future<bool> saveStorage(String id, List<String> data) async {
    return appRepository.saveStorage(id, data);
  }

  void getPostHair() {
    getPost(ID_HAIR_BEAUTY,TypePost.CATEGORY).then((value) {
      dataHairBeauty = value;
      notifyListeners();
    });
  }

  void getMakeUp() {
    getPost(ID_MAKEUP,TypePost.CATEGORY).then((value) {
      dataMakeUp = value;
      notifyListeners();
    });
  }

  void getSport() {
    getPost(ID_SPORT,TypePost.CATEGORY).then((value) {
      dataSport = value;
      notifyListeners();
    });
  }

  void getSkinBeauty() {
    getPost(ID_SKIN_BEATY,TypePost.CATEGORY).then((value) {
      dataSkinBeauty = value;
      notifyListeners();
    });
  }

  void getWearBeauty() {
    getPost(ID_WEAR_BEAUTY,TypePost.CATEGORY).then((value) {
      dataWearBeauty = value;
      notifyListeners();
    });
  }

  Future<List<Comment>> getComment(String id) async {
    return appRepository.getComment(id);
  }

  Future<bool> insertComment(String id, Comment data) async {
    return appRepository.insertComment(id, data);
  }

  Future<bool> insertCommentReply(String id,String idReply, List<Map<String, dynamic>> data) async {
    return appRepository.insertCommentReply(id,idReply,data);
  }

  Future<bool> deleteComment(String id, String idComment) async {
    return appRepository.deleteComment(id, idComment);
  }

  Future<Result<List<Post>>> search(String search) async {
    return appRepository.search(search);
  }

  void onLoad() {
    getPostHair();
    getMakeUp();
    getSport();
    getSkinBeauty();
    getWearBeauty();
    getStoragePost(currentUser);
  }

}