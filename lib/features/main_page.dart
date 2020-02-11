import 'package:flutter/material.dart';

import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  PageController _pageController;

  int indexTab = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            color: Color(0xffE81667),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      'Beauty Care',
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Icon(Icons.search, color: Colors.white,),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(height + 48),
      ),
      body: Container(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            Container(color: Colors.red,),
            Container(color: Colors.tealAccent,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        child: Icon(
          Icons.home,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () {
          setState(() {
            _pageController.jumpToPage(0);
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
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.shifting,
                currentIndex: indexTab,

                onTap: (index) {
                  _pageController.jumpToPage(index + 1);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: _getTabIcon(Icons.favorite, 1),
                      title: _getTabTitle('Favorite',1)
                  ),
                  BottomNavigationBarItem(
                      icon: _getTabIcon(Icons.notifications, 2),
                      title: _getTabTitle('Notification',2)
                  ),
                ],
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
      color: indexTab == index ? Color(0xffE81667) : Color(0xffE81667).withOpacity(0.5)
    ));
  }

}