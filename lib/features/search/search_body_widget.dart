import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/features/detail/detail_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';

class SearchBodyWidget extends StatefulWidget {
  @override
  _SearchBodyWidgetState createState() => _SearchBodyWidgetState();
}

class _SearchBodyWidgetState extends State<SearchBodyWidget> {
  GlobalKey<FormState> _keyForm = GlobalKey();

  AppBloc _appBloc;

  String search;

  List<Post> data = [];

  List<Post> dataSearch = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: _search,
                    icon: Icon(
                      Icons.send,
                      color: PINK,
                    ),
                  )),
              onSaved: (value) {
                search = value.trim();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Bạn chưa nhập từ khoá tìm kiếm ';
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: _itemSearch(),
          )
        ],
      ),
    );
  }

  void _search() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();
      showDialogProgressLoading(context, _appBloc.search(search))
          .then((value) {
            if (value.asValue.value.isEmpty) {
              setState(() {
                dataSearch = [];
              });
            } else {
              getDataSearch(value.asValue.value);
            }

      });
    }
  }

  void getDataSearch(List<Post> datas) {
    dataSearch = [];
    data = [];
    datas.forEach((element) {
      if (removeDiacritics(element.title.toLowerCase()).contains(removeDiacritics(search.toLowerCase()))) {
        data.add(element);
      }
    });
    if (data.isNotEmpty) {
      setState(() {
        dataSearch = data;
      });
    }
  }


  Widget _itemSearch() {
    return Container(
        child: GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: dataSearch?.length ?? 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          scrollDirection: Axis.vertical,
          cacheExtent: 4,
          itemBuilder: (context, index) {
            if (dataSearch.isEmpty) {
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
                    return DetailPage(dataSearch[index]);
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
                              dataSearch[index].thumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Text(
                            dataSearch[index].title,
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
}
