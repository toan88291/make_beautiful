import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_in/sign_in_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/resource/icon.dart';
import 'package:flutter_app_make_beautiful/widget/home_menu_popup.dart';
import 'package:provider/provider.dart';
import 'auth/sign_up/sign_up_page.dart';
import 'home/home_page.dart';
import 'news/news_page.dart';
import 'storage/storage_page.dart';
import 'dart:developer' as developer;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const String TAG = 'MainPage';

  AppBloc _appBloc;

  PageController _pageController;

  SignInUser user;

  int indexTab = 2;

  int check = 2;

  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  Widget loadPage(int check) {
    switch (check) {
      case 0:
        return NewsPage();
        break;
      case 1:
        return StoragePage();
        break;
      default:
        return HomePage();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
//    if (_appBloc.idUser != null) {
//      _appBloc.getUser(_appBloc.idUser).then((value) {
//        setState(() {
//          user = value;
//          developer.log(' user: $user', name: TAG);
//        });
//      });
//    }
    developer.log('current user: ${_appBloc.currentUser}', name: TAG);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: PreferredSize(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  _appBloc.currentUser == null
                      ? Container(
                          width: 48,
                          height: 48,
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
                              child: _appBloc.currentUser != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(_appBloc.currentUser.avatar),
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
                        'Beauty Care',
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
                    child: Icon(
                      Icons.search,
                      color: PINK,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(height + 52),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
                child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 1000),
              reverse: true,
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: _transitionType,
                );
              },
              child: loadPage(check),
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          child: Icon(
            Icons.home,
            color: indexTab == 2
                ? Color(0xff2EC492)
                : Color(0xff2EC492).withOpacity(0.7),
          ),
          onPressed: () {
            setState(() {
              check = 2;
              _pageController.jumpToPage(0);
              setState(() {
                indexTab = 2;
              });
              print('home ');
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(boxShadow: kElevationToShadow[4]),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: BottomAppBar(
                  child: BottomNavigationBar(
                    onTap: (index) {
                      _pageController.jumpToPage(index + 1);
                      setState(() {
                        check = index;
                        indexTab = index;
                        debugPrint('index: $index');
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: _getTabIcon(Icons.update, 0),
                          title: _getTabTitle('Mới nhất', 0)),
                      BottomNavigationBarItem(
                          icon: _getTabIcon(Icons.assignment, 1),
                          title: _getTabTitle('Lưu trữ', 1)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _getTabIcon(IconData icon, int index) {
    return Icon(icon,
        color: indexTab == index
            ? Color(0xffE81667)
            : Color(0xffE81667).withOpacity(0.5));
  }

  Widget _getTabTitle(String title, int index) {
    return Text(title,
        style: TextStyle(
          color: indexTab == index
              ? Color(0xffE81667)
              : Color(0xffE81667).withOpacity(0.5),
        ));
  }
}
