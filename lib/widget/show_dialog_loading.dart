import 'package:flutter/material.dart';

import 'loadding.dart';

Future<T> showDialogProgressLoading<T>(
    BuildContext context, Future<T> future) async {
  var route = PageRouteBuilder(
      pageBuilder: (context, v1, v2) => DialogProgressLoading(), opaque: false);
  Navigator.of(context).push(route);
  try {
    T response = await future;
    if (route.isActive) {
      Navigator.of(context).pop();
    }
    return response;
  } catch (error) {
    if (route.isActive) {
      Navigator.of(context).pop();
    }
    return Future.error(error);
  }
}