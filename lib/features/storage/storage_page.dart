import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  AppBloc _appBloc;

  List<Post> data;

  VoidCallback onLoad;

  @override
  void initState() {
    super.initState();
    onLoad = () {
      if (_appBloc.dataStorage.isNotEmpty) {
        setState(() {
          data = _appBloc.dataStorage;
        });
      } else {
        setState(() {

        });
      }
    };
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    _appBloc.addListener(onLoad);
    if (data == null) {
      setState(() {
        data = _appBloc.dataStorage;
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
  void dispose() {
    super.dispose();
    _appBloc.removeListener(onLoad);
  }

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (data.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          'Rỗng !!!',
          style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: Colors.red
          ),
        ),
      );
    } else if (data == null){
      return Container(
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: width/((height/2)),
            ),
            scrollDirection: Axis.vertical,
            cacheExtent: 8,
            itemBuilder: (context, index) {
              return shimmerContainer(context);
            },
          )
      );
    } else {
      return Container(
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: data.length ?? 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            scrollDirection: Axis.vertical,
            cacheExtent: 8,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return DetailPage(data[index]);
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
                              data[index].thumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Text(
                            data[index].title,
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
            },
          )
      );
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