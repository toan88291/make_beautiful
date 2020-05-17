import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/widget/app_header_category_widget.dart';

import 'search_body_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppHeaderCategoryWidget(height,'Search'),
      body: SearchBodyWidget(),
    );
  }
}