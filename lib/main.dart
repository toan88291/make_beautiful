import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'theme/custom_theme_data.dart';
import 'theme/dynamic_theme_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String TAG = 'MyApp';

  @override
  Widget build(BuildContext context) {
    return DynamicThemeWidget(
      customThemeData: CustomThemeData.light(),
      initThemeData: ThemeData.light().copyWith(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.light().copyWith(
            onPrimary: Colors.black,
            secondary: Colors.yellowAccent[400],
            primary: Colors.grey,
          ),

          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              )
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black87,
            labelStyle: GoogleFonts.quicksand().copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w800
            ),
            unselectedLabelColor: Colors.black54,
            unselectedLabelStyle: GoogleFonts.quicksand().copyWith(
                color: Colors.black54
            ),
          ),

      ),
      initLocale: Locale('vi','VI'),
      child: Application(),
    );
  }
}

