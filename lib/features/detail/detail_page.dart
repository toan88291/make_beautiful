import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatefulWidget {
  final Post data;

  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin{

  SignInUser currentUser;

  AppBloc _categoryBloc;

  TabController _tabController;

  PageController _pageController;


  @override
  void initState() {
    super.initState();
    _categoryBloc = Provider.of(context, listen: false);
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (currentUser == null) {
      currentUser = _categoryBloc.currentUser;
    }
    debugPrint('current user: ${_categoryBloc.currentUser}');
  }

  bool isLiked() {
    bool checked = false;
    widget.data.like.forEach((element) {
      if (element == currentUser.docId) {
        setState(() {
          checked = true;
        });
      }
    });
    return checked;
  }

  int getLengthImage() {
    int length = 0;
    widget.data.content.forEach((element) {
      if (element.contains('image:')) {
        length++;
      }
    });
    return length;
  }

  List<Widget> _getContent() {
    List<Widget> data = [];
    int count = 0;
    int lengthImage = getLengthImage();
    widget.data.content.forEach((element) {
      if (element.contains('content:')) {
        data.add(Container(
          child: Text(element.substring(8, element.length)),
        ));
      }
      if (count < lengthImage ) {
        data.add(
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                  element.substring(6,element.length),
                  fit: BoxFit.cover,
                  frameBuilder: (BuildContext context, Widget child, int frame,
                      bool wasSynchronouslyLoaded){
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return frame == null ? Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ) : Image.network(
                      element.substring(6,element.length),
                      fit: BoxFit.cover,
                    );
                  }
              ),
            )
        );
      }
      count++;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, bool) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                leading: BackButton(
                  color: PINK,
                ),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Text(widget.data.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    ),
                    background: Image.network(
                      widget.data.thumb,
                      fit: BoxFit.cover,
                    ))),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 48,
                  width: double.infinity,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index){
                      _pageController.jumpToPage(index);
                    },
                    tabs: <Widget>[
                      Tab(
                        text: 'Nội Dung',
                      ),
                      Tab(
                        text: 'Bình Luận',
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    allowImplicitScrolling: false,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    right: 0,
                                    top: -12,
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      margin: EdgeInsets.only(right: 4),
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                            )
                                          ]),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: isLiked() ? Colors.red : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 52.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            widget.data.category,
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                        ),
                                        Text(
                                          '<',
                                          style: Theme.of(context).textTheme.headline6,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            widget.data.sub_category,
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Column(
                                children: _getContent(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
