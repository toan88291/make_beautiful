import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/category.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sub_category.dart';
import 'package:flutter_app_make_beautiful/widget/app_header_category_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_sub_category_widget.dart';

class CategoryPage extends StatefulWidget {
  final Category data;

  CategoryPage(this.data);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  AppBloc _appBloc;

  List<SubCategory> datas;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    _appBloc.getSubCategory(widget.data.docId).then((value) {
      setState(() {
        datas = value.asValue.value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppHeaderCategoryWidget(height, widget.data.name),
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/background.png',
            )
          )
        ),
        child: datas != null ? Container(
          child: ListView.builder(
            itemCount: datas?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return DetailSubCategoryWidget(datas[index]);
                  }));
                },
                child: _itemCard(datas[index]),
              );
            },
          ),
        ) : Container(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _itemCardShimmer();
            },
          ),
        ),
      ),
    );
  }

  Widget _itemCard(SubCategory datas) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.network(
                datas.image,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
                frameBuilder: (BuildContext context, Widget child, int frame,
                    bool wasSynchronouslyLoaded){
                  if (wasSynchronouslyLoaded) {
                    return child;
                  }
                  return frame == null ? Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ) : Image.network(
                    datas.image,
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                  );
                }
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      datas.name,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text(
                      datas.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _itemCardShimmer() {
    return Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          height: 32,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

}