import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void direction() async {
    Future.delayed(Duration(seconds: 1), (){
      Navigator.of(context).pushReplacementNamed('main');
    });
  }

  @override
  void initState() {
    super.initState();
    direction();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width /2;
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffE81667).withOpacity(0.5),
          ),
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xffE81667).withOpacity(0.7),
              shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logo.png')
                )
            ),
          ),
        )
      )
    );
  }
}