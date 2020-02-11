import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/data_grid_menu.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataGridMenu> data = [
    DataGridMenu('Da Đẹp','',''),
    DataGridMenu('Trang Điểm','',''),
    DataGridMenu('Tóc Đẹp','',''),
    DataGridMenu('Mặc Đẹp','',''),
    DataGridMenu('Dáng Đẹp','',''),
    DataGridMenu('Tập Luyện','',''),
  ];
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffE81667).withOpacity(0.7),
                  Color(0xffE81667).withOpacity(0.5),
                  Color(0xffE81667).withOpacity(0.3),
                  Color(0xffE81667).withOpacity(0.1),
                ]
              )
            ),
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: width/((height/2)),
              ),
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return ItemGridWidget(data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}