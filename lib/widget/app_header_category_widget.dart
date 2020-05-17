import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';

class AppHeaderCategoryWidget extends StatelessWidget implements PreferredSizeWidget{
  final double height;

  final String title;

  AppHeaderCategoryWidget(this.height, this.title);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20).copyWith(
            top: height
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                    'assets/background-appbar.png'
                )
            )
        ),
        child: Row(
          children: <Widget>[
            BackButton(color: PINK,),
            Expanded(
              child: Container(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: PINK,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height + 52);

}
