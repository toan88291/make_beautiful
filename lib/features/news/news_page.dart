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
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: dataPost?.length ?? 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: width/((height/2)),
        ),
        scrollDirection: Axis.vertical,
        cacheExtent: 8,
        itemBuilder: (context, index) {
          if (dataPost == null) {
            return shimmerContainer(context);
          } else if (dataPost.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Rỗng !!!',
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
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image.network(
                            dataPost[index].thumb,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          width: (width/2) - 40,
                          color: Colors.transparent,
                          child: Text(
                            dataPost[index].title,
                            style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.pink,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      )
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
