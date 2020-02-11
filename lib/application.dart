import 'package:flutter/material.dart';

import 'features/features.dart';
import 'theme/dynamic_theme_widget.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DynamicTheme.of(context).themeData,
      routes: {
        'splash': (context) => SplashScreen(),
        'main': (context) => MainPage(),
      },
      initialRoute: 'splash',
    );
  }
}
