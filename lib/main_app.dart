import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:google_fonts/google_fonts.dart';

import 'application.dart';
import 'theme/custom_theme_data.dart';
import 'theme/dynamic_theme_widget.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicThemeWidget(
      customThemeData: CustomThemeData.light(),
      initThemeData: ThemeData.light().copyWith(
        primaryColor: PINK,
        colorScheme: ColorScheme.light().copyWith(
          onPrimary: Colors.black,
          secondary: Colors.white,
          primary: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                title: TextStyle(
                    color: PINK,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )
            )
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffFF8C29),
            ),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffDADADA),
            ),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
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
        buttonTheme: ButtonThemeData(
          buttonColor: PINK, // Background color (orange in my case).
          textTheme: ButtonTextTheme.accent,
          colorScheme: ThemeData.dark().colorScheme.copyWith(
            secondary: Colors.white,
          ),
        ),

      ),
      initLocale: Locale('vi','VI'),
      child: Application(),
    );
  }
}
