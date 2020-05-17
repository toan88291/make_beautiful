import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_in/sign_in_page.dart';
import 'package:flutter_app_make_beautiful/features/search/search_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'home_menu_popup.dart';

class AppBarHeaderWidget extends StatelessWidget implements PreferredSizeWidget{
  final double height;

  final String title;

  AppBarHeaderWidget(this.height, this.title);

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
            Provider.of<AppBloc>(context).currentUser == null
                ? Container(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignInPage();
                    }));
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      AppIcons.icAvatar,
                    ),
                  )),
            )
                : Container(
              width: 48,
              height: 48,
              child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context, child: HomeMenuPopup());
                  },
                  child: Provider.of<AppBloc>(context).currentUser != null
                      ? ClipOval(
                    child: Image.network(
                      Provider.of<AppBloc>(context).currentUser?.avatar,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      frameBuilder: (BuildContext context, Widget child,
                          int frame, bool wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }
                        return frame == null
                            ? Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[100]),
                          ),
                        )
                            : Image.network(
                          Provider.of<AppBloc>(context).currentUser.avatar,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                      : CircleAvatar(
                    backgroundImage: AssetImage(
                      AppIcons.icAvatar,
                    ),
                  )),
            ),
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
            Container(
              height: 48,
              width: 48,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return SearchPage();
                  }));
                },
                icon: Icon(Icons.search),
                color: PINK,
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
