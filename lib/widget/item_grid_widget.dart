import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:shimmer/shimmer.dart';

class ItemGridWidget extends StatelessWidget {

  final Category data;

  ItemGridWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
              data.icon,
              height: 48,
              width: 48,
              frameBuilder: (BuildContext context, Widget child, int frame,
                  bool wasSynchronouslyLoaded){
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return frame == null ? Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                     color: Colors.grey[100],
                     borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ) : Image.network(
                  data.icon,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                );
              }
            ),
            Text(
              data.name,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.black87
              ),
            )
          ],
        ),
      ),
    );
  }
}
