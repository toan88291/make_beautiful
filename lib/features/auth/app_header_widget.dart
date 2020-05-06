import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class AppHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final Widget title;
  final Widget subTitle;
  final String logo;
  final double elevation;

  AppHeaderWidget(
      {this.leading, this.title, this.subTitle, this.logo, this.elevation = 2})
      : super();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: elevation,
      child: SafeArea(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconTheme(
                          data: IconThemeData(
                              color: Colors.white,
                            size: 48
                          ),
                          child: leading
                      ),
                      Expanded(
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                DefaultTextStyle(
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6,
                                    child: title
                                ),
                                Divider(
                                  color: Colors.transparent,
                                  height: 8,
                                ),
                                DefaultTextStyle(
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle1,
                                    child: subTitle
                                ),
                              ],
                            ),
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      )
                ],
              )),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          logo,
                      )
                    )
                  ),
                ),
              )
            ],
      )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48 + 88.0);
}
