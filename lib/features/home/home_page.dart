import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'dart:developer' as developer;
import 'package:flutter_app_make_beautiful/data/data_grid_menu.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String TAG = 'HomePage';

  AppBloc categoryBloc;

  List<Category> categoryData;

  VoidCallback onChange;

  @override
  void initState() {
    super.initState();
    onChange = () {
      setState(() {

      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (categoryBloc == null) {
      categoryBloc = Provider.of(context);
      categoryBloc.getCategory();
      categoryBloc.addListener(onChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    categoryBloc.removeListener(onChange);
  }

  List<DataDressed> dataDressed =
  []..add(DataDressed('assets/image.jpg', 'Happy Hallowen 2019', 'Music show'))
    ..add(DataDressed('assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed('assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed('assets/image.jpg', 'Happy New Year', 'Music show'));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        shrinkWrap: false,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: (6~/3) * 140.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/background.png',
                    )
                  ),
              ),
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: categoryBloc.categoryData.asValue.value?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,

                ),
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return ItemGridWidget(categoryBloc.categoryData.asValue.value[index]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 4),
              height: 60,
              child: Image.asset('assets/banner.jpg',fit: BoxFit.fitWidth,)
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Mặc Đẹp',style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text('Xem Hết',style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: PINK
                  ),)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: dataDressed.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DressedBeautyWidget(dataDressed[index]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Trang Điểm',style: Theme.of(context).textTheme.title.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
                  Text('Xem Hết',style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: PINK
                  ),)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: dataDressed.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DressedBeautyWidget(dataDressed[index]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Trang Điểm',style: Theme.of(context).textTheme.title.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
                  Text('Xem Hết',style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: PINK
                  ),)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: dataDressed.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DressedBeautyWidget(dataDressed[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataDressed {

  String image;

  String title;

  String subtitle;

  DataDressed(this.image, this.title, this.subtitle);

}