import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/data_grid_menu.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DataGridMenu> data = [
    DataGridMenu('Da Đẹp','assets/ic_face.png',''),
    DataGridMenu('Trang Điểm','assets/ic_makeup.jpg',''),
    DataGridMenu('Tóc Đẹp','assets/ic_makeup.jpg',''),
    DataGridMenu('Mặc Đẹp','assets/ic_makeup.jpg',''),
    DataGridMenu('Tin Tức','assets/ic_makeup.jpg',''),
    DataGridMenu('Thể Thao','assets/ic_makeup.jpg',''),
  ];

  List<DataDressed> dataDressed =
  []..add(DataDressed('assets/image.jpg', 'Happy Hallowen 2019', 'Music show'))
    ..add(DataDressed('assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed('assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed('assets/image.jpg', 'Happy New Year', 'Music show'));

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    debugPrint('heght : ${(data.length~/3) * 60.0}');

    return Container(
      padding: EdgeInsets.only(bottom: 60),
      child: CustomScrollView(
        shrinkWrap: false,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: (data.length~/3) * 140.0,
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
                itemCount: data.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,

                ),
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return ItemGridWidget(data[index]);
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