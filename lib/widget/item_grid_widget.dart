import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/data_grid_menu.dart';

class ItemGridWidget extends StatelessWidget {

  final DataGridMenu data;

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
            Image.asset(data.icon, height: 48, width: 48,),
            Text(
              data.title,
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
