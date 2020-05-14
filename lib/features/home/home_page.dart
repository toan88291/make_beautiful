import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'dart:developer' as developer;
import 'package:flutter_app_make_beautiful/features/category/detail_category_widget.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/widget/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String TAG = 'HomePage';

  AppBloc _appBloc;

  VoidCallback onChange;

  @override
  void initState() {
    super.initState();
    onChange = () {
      setState(() {

      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_appBloc == null) {
      _appBloc = Provider.of(context);
      _appBloc.getCategory();
      _appBloc.addListener(onChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _appBloc.removeListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        shrinkWrap: false,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: (6~/3) * 140.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/background.png',
                    )
                  ),
              ),
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: _appBloc.categoryData.asValue.value?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,

                ),
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return ItemGridWidget(_appBloc.categoryData.asValue.value[index]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 4),
              height: 60,
              child: Image.asset('assets/banner.jpg',fit: BoxFit.fitWidth,)
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Text('Make Up',style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DetailCategoryWidget(ID_HAIR_BEAUTY,'Tóc Đẹp');
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Text('Xem Hết',style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: PINK
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 200,
              child: ListView.separated(
                itemCount: _appBloc.dataHairBeauty?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index < 9) {
                    return DressedBeautyWidget(_appBloc.dataHairBeauty[index]);
                  }
                  return null;
                },
                separatorBuilder: (context, index) {
                  if (index < 9) {
                    return SizedBox(width: 8,);
                  }
                  return null;
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Text('Mặc Đẹp',style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DetailCategoryWidget(ID_HAIR_BEAUTY,'Tóc Đẹp');
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Text('Xem Hết',style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: PINK
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 200,
              child: ListView.separated(
                itemCount: _appBloc.dataHairBeauty?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index < 9) {
                    return DressedBeautyWidget(_appBloc.dataHairBeauty[index]);
                  }
                  return null;
                },
                separatorBuilder: (context, index) {
                  if (index < 9) {
                    return SizedBox(width: 8,);
                  }
                  return null;
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Text('Thể Thao',style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DetailCategoryWidget(ID_HAIR_BEAUTY,'Tóc Đẹp');
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Text('Xem Hết',style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: PINK
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 200,
              child: ListView.separated(
                itemCount: _appBloc.dataHairBeauty?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index < 9) {
                    return DressedBeautyWidget(_appBloc.dataHairBeauty[index]);
                  }
                  return null;
                },
                separatorBuilder: (context, index) {
                  if (index < 9) {
                    return SizedBox(width: 8,);
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataDressed {

  String image;

  String title;

  String subtitle;

  DataDressed(this.image, this.title, this.subtitle);

}