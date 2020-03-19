import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/features/home/home_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<DataDressed> dataDressed = []
    ..add(DataDressed('assets/image.jpg', 'Happy Hallowen 2019', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Music DJ King Monger Sert', 'Music show'))
    ..add(DataDressed(
        'assets/image.jpg', 'Summer Sounds Festival', 'Comedy show'))
    ..add(DataDressed('assets/image.jpg', 'Happy New Year', 'Music show'));

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      child: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: dataDressed.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: width/((height/2)),
        ),
        scrollDirection: Axis.vertical,
        cacheExtent: 8,
        itemBuilder: (context, index) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(dataDressed[index].image, fit: BoxFit.fill,),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    width: (width/2) - 40,
                    child: Text(
                      dataDressed[index].title,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: Colors.black87
                      ),
                    ),
                  ),
                )
              ],
            )
          );
        },
      )
    );
  }
}
