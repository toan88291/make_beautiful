import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/repository/category_repository.dart';
import 'package:flutter_app_make_beautiful/main_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: FirebaseOptions(
      googleAppID: (Platform.isIOS || Platform.isMacOS)
          ? '1:313387706957:ios:b3699a1c30ba7ea0f44a04'
          : '1:313387706957:android:9afd54b033955c13f44a04',
      gcmSenderID: '313387706957',
      apiKey: 'AIzaSyDTHZnk2Vc8Cwuv_3kA5iW8yaweDwYm4Y4',
      projectID: 'beautiful-care',
    ),
  );

  FirebaseStorage(app: app, storageBucket: 'gs://beautiful-care.appspot.com');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String TAG = 'MyApp';

  @override
  Widget build(BuildContext context) {
    CategoryRepository categoryRepository = CategoryRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppBloc(categoryRepository: categoryRepository),
        )
      ],
      child: MainApp(),
    );
  }
}
