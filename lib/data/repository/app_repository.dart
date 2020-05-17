import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/request/sign_up_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sub_category.dart';
import 'dart:developer' as developer;

import 'package:flutter_app_make_beautiful/data/model/response/user_comment.dart';

class AppRepository {
  static final TAG = "AppRepository";

  final Firestore _store = Firestore.instance;

  final String collectionPost = 'post';

  final String collectionCategory = 'category';

  final String collectionUser = 'user';

  final String collectionSubCategory = 'sub_category';

  final String collectionComment = 'comment';

  ValueNotifier<void> firebaseUser;

  AppRepository() {
    firebaseUser = ValueNotifier(null);
  }

  Future<Result<List<Category>>> getCategory() async {
    List<Category> datas = [];
    QuerySnapshot data =
        await _store.collection(collectionCategory).getDocuments();

    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Category.fromJson(doc.data)..docId = doc.documentID);
      }
    }
    return Result.value(datas);
  }

  Future<Result<List<SubCategory>>> getSubCategory(String id) async {
    List<SubCategory> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionCategory)
        .document(id)
        .collection(collectionSubCategory)
        .getDocuments();

    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(SubCategory.fromJson(doc.data)..docId = doc.documentID);
      }
    }
    return Result.value(datas);
  }

  Future<Result<List<Post>>> getNewPost() async {
    List<Post> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionPost)
        .orderBy('date_time', descending: true)
        .limit(20)
        .getDocuments();
    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Post.fromJson(doc.data)..docId = doc.documentID);
      }
    }
    return Result.value(datas);
  }

  Future<Result<Post>> getStoragePost(String id) async {
    Post datas;
    DocumentReference documentReference =
        _store.collection(collectionPost).document(id);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    datas = Post.fromJson(documentSnapshot.data)..docId = documentSnapshot.documentID;
    debugPrint('getStoragePost $datas');
    return Result.value(datas);
  }

  Future<bool> saveStorage(String id, List<String> data) async {
    DocumentReference documentReference = _store
        .collection(collectionUser)
        .document(id);
    await documentReference.updateData({'save_post': data});
    return documentReference.updateData({'save_post': data}) != null;
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
    DocumentReference documentReference =
        _store.collection(collectionUser).document(id);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    map = documentSnapshot.data;
    results = SignInUser.fromJson(map)..docId = documentSnapshot.documentID;
    return results;
  }

  Future<bool> forgotPass(SignInUser user) async {
    DocumentReference documentReference =
        _store.collection(collectionUser).document(user.docId);
    return documentReference.updateData(user.toJson()) != null;
  }

  Future<bool> isCheckUser(String user) async {
    QuerySnapshot querySnapshot = await _store
        .collection(collectionUser)
        .where("username", isEqualTo: user.toLowerCase())
        .getDocuments();
    return querySnapshot.documents.length > 0;
  }

  Future<bool> changeInfo(SignInUser user) async {
    DocumentReference documentReference =
        _store.collection(collectionUser).document(user.docId);
    return documentReference.updateData(user.toJson()) != null;
  }

  Future<bool> isLiked(List<String> like, String docId) async {
    DocumentReference documentReference =
        _store.collection(collectionPost).document(docId);
    await documentReference.updateData({"like": like});
    return documentReference.updateData({"like": like}) != null;
  }

  Future<List<Post>> getPost(String id, TypePost typePost) async {
    List<Post> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionPost)
        .where(
            TypePost.CATEGORY != typePost ? "sub_category_id" : "category_id",
            isEqualTo: id)
        .getDocuments();
    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Post.fromJson(doc.data)..docId = doc.documentID);
      }
    }
    return datas;
  }

  Future<List<Comment>> getComment(String id) async {
    List<Comment> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionPost)
        .document(id)
        .collection(collectionComment)
        .getDocuments();
    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Comment.fromJson(doc.data)..docId = doc.documentID..isReply = false);
      }
    }
    return datas;
  }

  Future<bool> insertComment(String id, Comment data) async {
    DocumentReference documentReference = _store
        .collection(collectionPost)
        .document(id)
        .collection(collectionComment)
        .document();
    return documentReference.setData(data.toJson()) != null;
  }

  Future<bool> insertCommentReply(String id,String idReply, List<Map<String, dynamic>> data) async {
    DocumentReference documentReference = _store
        .collection(collectionPost)
        .document(id)
        .collection(collectionComment)
        .document(idReply);
    return documentReference.setData({'reply_comment': data},merge: true) != null;
  }

  Future<bool> deleteComment(String id, String idComment) async {
    DocumentReference documentReference = _store
        .collection(collectionPost)
        .document(id)
        .collection(collectionComment)
        .document(idComment);
    return documentReference.delete() != null;
  }

  Future<bool> deleteReplyComment(String id, String idComment) async {
    DocumentReference documentReference = _store
        .collection(collectionPost)
        .document(id)
        .collection(collectionComment)
        .document(idComment);
    return documentReference.delete() != null;
  }

  Future<Result<List<Post>>> search(String search) async {
    List<Post> datas = [];
    QuerySnapshot data = await _store
        .collection(collectionPost)
        .getDocuments();
    if (data.documents.length > 0) {
      for (DocumentSnapshot doc in data.documents) {
        datas.add(Post.fromJson(doc.data)..docId = doc.documentID);
      }
    }
    return Result.value(datas);
  }
  
}

enum TypePost { CATEGORY, SUB_CATEGORY }
