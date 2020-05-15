import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  AppBloc categoryBloc;

  List<Post> dataPost;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (categoryBloc == null) {
      categoryBloc = Provider.of(context, listen: false);
      categoryBloc.getNewPost().then((value) {
        if(value.isValue) {
          setState(() {
            dataPost = value.asValue.value;
          });
        }
      });
    }
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: dataPost?.length ?? 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        scrollDirection: Axis.vertical,
        cacheExtent: 4,
        itemBuilder: (context, index) {
          if (dataPost == null) {
            return shimmerContainer(context);
          } else if (dataPost.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Danh sách trống !!!',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.red
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return DetailPage(dataPost[index]);
                }));
              },
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image.network(
                            dataPost[index].thumb,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Text(
                          dataPost[index].title,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.pink,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          }
        },
      )
    );
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
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: Colors.black87
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
