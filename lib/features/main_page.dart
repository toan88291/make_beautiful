import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'home/home_page.dart';
import 'news/news_page.dart';
import 'storage/storage_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  PageController _pageController;

  int indexTab = 2;

  int check = 2;

  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  Widget loadPage(int check) {
    switch (check) {
      case 0 :
        return NewsPage();
        break;
      case 1 :
        return StoragePage();
        break;
      default:
        return HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      'Beauty Care',
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: PINK
                      ),
                    ),
                  ),
                ),
                Icon(Icons.search, color: PINK,),
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
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        child: Icon(
          Icons.home,
          color: indexTab == 2 ? Color(0xff2EC492) : Color(0xff2EC492).withOpacity(0.7),
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
      extendBody: true,
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[4]
            ),
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
                        title: _getTabTitle('Mới nhất',0)
                    ),
                    BottomNavigationBarItem(
                        icon: _getTabIcon(Icons.assignment, 1),
                        title: _getTabTitle('Lưu trữ',1)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _getTabIcon(IconData icon, int index) {
    return Icon(
      icon,
      color: indexTab == index ? Color(0xffE81667) : Color(0xffE81667).withOpacity(0.5)
    );
  }

  Widget _getTabTitle(String title,  int index) {
    return Text(
      title,
      style: TextStyle(
      color: indexTab == index ? Color(0xffE81667) : Color(0xffE81667).withOpacity(0.5),
    ));
  }

}