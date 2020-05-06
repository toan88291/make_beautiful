import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  AppBloc _appBloc;

  List<Post> data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context);
    debugPrint('StoragePage data: ${_appBloc?.dataStorage?.length}');
  }
  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: _appBloc?.dataStorage?.length ?? 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: width/((height/2)),
          ),
          scrollDirection: Axis.vertical,
          cacheExtent: 8,
          itemBuilder: (context, index) {
            if (_appBloc?.dataStorage == null) {
              return shimmerContainer(context);
            } else if (_appBloc.dataStorage.isEmpty) {
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
                    return DetailPage(_appBloc?.dataStorage[index]);
                  }));
                },
                child: Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.network(
                              _appBloc?.dataStorage[index].thumb,
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
                              _appBloc?.dataStorage[index].title,
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