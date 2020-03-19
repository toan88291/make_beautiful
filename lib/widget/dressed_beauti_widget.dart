import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/features/features.dart';

class DressedBeautyWidget extends StatefulWidget {

  final DataDressed data;

  DressedBeautyWidget(this.data);

  @override
  _DressedBeautyWidgetState createState() => _DressedBeautyWidgetState();
}

class _DressedBeautyWidgetState extends State<DressedBeautyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Image.asset(widget.data.image, fit: BoxFit.cover,height: 120,),
          ),
          SizedBox(height: 4,),
          Text(
            widget.data.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14
            ),
          ),
          SizedBox(height: 4,),
          Text(
            widget.data.subtitle,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}