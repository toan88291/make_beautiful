import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/user.dart';

class CategoryRepository {
  final Firestore _store = Firestore.instance;

  final String collectionPost = 'post';

  final String collectionCategory = 'category';

  final String collectionUser = 'user';

  final String collectionSubCategory = 'sub_category';

  final String collectionComment = 'comment';

  ValueNotifier<void> firebaseUser;

  CategoryRepository() {
    firebaseUser = ValueNotifier(null);
  }

  Future<Result<List<Category>>> getCategory() async {
    List<Category> datas = [];
    QuerySnapshot data =
        await _store.collection(collectionCategory).getDocuments();

    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Category.fromJson(doc.data));
      }
    }
    return Result.value(datas);
  }

  Future<Result<List<Post>>> getNewPost() async {
    List<Post> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionPost)
        .orderBy('date_time')
        .limit(20)
        .getDocuments();
    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Post.fromJson(doc.data));
      }
    }
    return Result.value(datas);
  }

  Future<Result<Post>> getStoragePost(String id) async {
    Post datas;
    DocumentReference documentReference = _store.collection(collectionPost)
        .document(id);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    datas = Post.fromJson(documentSnapshot.data);
    debugPrint('getStoragePost $datas');
    return Result.value(datas);
  }

  Future<bool> insertUser(SignUpUser data) async {
    DocumentReference documentReference =
        _store.collection(collectionUser).document();
    return documentReference.setData(data.toJson()) != null;
  }

  Future<bool> isUser(String user, String pass) async {
    QuerySnapshot querySnapshot = await _store
        .collection(collectionUser)
        .where("username", isEqualTo: user.toLowerCase())
        .where("password", isEqualTo: pass)
        .getDocuments();
    return querySnapshot.documents != null;
  }

  Future<List<SignInUser>> login(String user, String pass) async {
    QuerySnapshot querySnapshot = await _store
        .collection(collectionUser)
        .where("username", isEqualTo: user.toLowerCase())
        .where("password", isEqualTo: pass)
        .getDocuments();
    List<SignInUser> results = querySnapshot.documents
        .map((data) => SignInUser.fromJson(data.data)..docId = data.documentID)
        .toList();

    return results;
  }

  Future<SignInUser> getUser(String id) async {
    SignInUser results;
    Map<String, dynamic> map;
    DocumentReference documentReference = _store.collection(collectionUser)
        .document(id);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    map = documentSnapshot.data;
    results = SignInUser.fromJson(map)..docId = documentSnapshot.documentID;
    return results;
  }

}
