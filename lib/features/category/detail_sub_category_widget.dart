import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sub_category.dart';
import 'package:flutter_app_make_beautiful/data/repository/app_repository.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailSubCategoryWidget extends StatefulWidget {
  final SubCategory data;

  DetailSubCategoryWidget(this.data);

  @override
  _DetailSubCategoryWidgetState createState() => _DetailSubCategoryWidgetState();
}

class _DetailSubCategoryWidgetState extends State<DetailSubCategoryWidget> {
  AppBloc _appBloc;

  List<Post> datas;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    _appBloc.getPost(widget.data.docId, TypePost.SUB_CATEGORY).then((value) {
      if (value != null) {
        setState(() {
          datas = value;
        });
      } else {
        setState(() {
          datas = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (datas == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: PINK,
            ),
            title: Text(
              widget.data.name,
            ),
            centerTitle: true,
          ),
          body: Container(
              child: GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: width / ((height / 2)),
            ),
            scrollDirection: Axis.vertical,
            cacheExtent: 8,
            itemBuilder: (context, index) {
              return shimmerContainer(context);
            },
          )));
    } else if (datas.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: PINK,
            ),
            title: Text(
              widget.data.name,
            ),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Text(
              'Danh sách trống !!!',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.red),
            ),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: PINK,
            ),
            title: Text(
              widget.data.name,
            ),
            centerTitle: true,
          ),
          body: Container(
              child: GridView.builder(
                padding: EdgeInsets.all(12),
                itemCount: datas?.length ?? 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                scrollDirection: Axis.vertical,
                cacheExtent: 8,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(datas[index]);
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Image.network(
                                  datas[index].thumb,
                                  fit: BoxFit.cover,
                                  frameBuilder: (BuildContext context, Widget child,
                                      int frame, bool wasSynchronouslyLoaded) {
                                    if (wasSynchronouslyLoaded) {
                                      return child;
                                    }
                                    return frame == null
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.grey[100],
                                            child: Container(
                                              height: 120,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100]),
                                            ),
                                          )
                                        : Image.network(
                                            datas[index].thumb,
                                            fit: BoxFit.cover,
                                          );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Text(
                                datas[index].title,
                                style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: Colors.pink, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                    )),
                  );
                },
          )));
    }
  }

  Widget shimmerContainer(context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Shimmer.fromColors(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                width: (MediaQuery.of(context).size.width) - 40,
                child: Text(
                  'Loadding...',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black87),
                ),
              ),
            )
          ],
    ));
  }
}
