import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogProgressLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: SimpleLoadingCenterWidget(),
    );
  }
}

class SimpleLoadingCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      ),
    ));
  }
}
