import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:flutter_app_make_beautiful/features/features.dart';
import 'package:shimmer/shimmer.dart';

class DressedBeautyWidget extends StatefulWidget {
  final Post data;

  DressedBeautyWidget(this.data);

  @override
  _DressedBeautyWidgetState createState() => _DressedBeautyWidgetState();
}

class _DressedBeautyWidgetState extends State<DressedBeautyWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return DetailPage(widget.data);
        }));
      },
      child: Container(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                widget.data.thumb,
                fit: BoxFit.cover,
                height: 120,
                frameBuilder: (BuildContext context, Widget child, int frame,
                    bool wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) {
                    return child;
                  }
                  return frame == null
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                 color: Colors.grey[100]
                            ),
                          ),
                      ) : Image.network(
                        widget.data.thumb,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 140,
                      );
                },
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.data.title,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.data.sub_category,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
