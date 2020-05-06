import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:provider/provider.dart';

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  AppBloc _appBloc;

  List<Post> data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    debugPrint('StoragePage data: ${_appBloc?.dataStorage?.length}');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Mục lưu trữ trống ${_appBloc?.dataStorage?.length}'),
    );
  }
}