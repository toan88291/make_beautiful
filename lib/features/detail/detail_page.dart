import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/post.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/data/model/response/user_comment.dart';
import 'package:flutter_app_make_beautiful/features/auth/sign_in/sign_in_page.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/utils/utils.dart';
import 'package:flutter_app_make_beautiful/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer' as developer;

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'comment_widget.dart';
import 'play_video_widget.dart';

class DetailPage extends StatefulWidget {
  final Post data;

  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  static final TAG = 'DetailPage';

  SignInUser currentUser;

  AppBloc _appBloc;

  TabController _tabController;

  PageController _pageController;

  VoidCallback onLoadComment;

  ValueChanged<Tuple3<bool,String,List<ReplyComment>>> onReplyComment;

  YoutubePlayerController _youtubePlayerController;

  TextEditingController _textEditingController  = TextEditingController();

  List<Widget> data = [];

  List<String> liked = [];

  List<String> saved = [];

  List<Comment> dataComment;

  List<Map<String, dynamic>> reply_comment = [];

  List<ReplyComment> reply_comment2 = [];

  String linkVideo;

  String idComment;

  bool checked = false;

  bool isSave = false;

  bool isComment = false;

  bool isReplyComment = false;

  String idReplyComment;

  @override
  void initState() {
    super.initState();
    _appBloc = Provider.of(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    setState(() {
      liked = widget.data.like;
      idComment = widget.data.docId;
    });
    onLoadComment = (){
      _getDataComment();
    };
    onReplyComment = (value) {
      setState(() {
        reply_comment.clear();
        isReplyComment = value.item1;
        idReplyComment = value.item2;
        reply_comment2 = value.item3;
      });
    };
    isLikePost();
    isSavePost();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (currentUser == null) {
      currentUser = _appBloc.currentUser;
      setState(() {
        saved = _appBloc.currentUser?.save_post;
      });
    }
    _getContent();
    isLikePost();
    isSavePost();
    _getDataComment();
    debugPrint('current user: ${_appBloc.currentUser?.save_post?.length}');
    debugPrint(' data: ${_appBloc.currentUser?.save_post?.length}');
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder: (context, forceElevated) {
                    return [
                      SliverOverlapAbsorber(
                        handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverAppBar(
                            leading: BackButton(),
                            centerTitle: true,
                            forceElevated: forceElevated,
                            pinned: true,
                            flexibleSpace:
                            Stack(overflow: Overflow.visible, children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black38, BlendMode.srcATop),
                                          image: NetworkImage(widget.data.thumb),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 60,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  margin: EdgeInsets.only(right: 4),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_appBloc.currentUser != null) {
                                        if (checked) {
                                          likePost(false);
                                        } else {
                                          likePost(true);
                                        }
                                      } else {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                          return SignInPage(check: true,);
                                        }));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: checked ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 60,
                                bottom: 60,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  margin: EdgeInsets.only(left: 4),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_appBloc.currentUser != null) {
                                        if (isSave) {
                                          savePost(false);
                                        } else {
                                          savePost(true);
                                        }
                                      } else {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                          return SignInPage(check: true,);
                                        }));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: isSave ? PINK : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            stretchTriggerOffset: kToolbarHeight,
                            expandedHeight: kToolbarHeight + 200,
                            bottom: PreferredSize(
                              child: Container(
                                color: Colors.white,
                                child: TabBar(
                                  onTap: (index) {
                                    setState(() {
                                      index == 1
                                          ? isComment = true
                                          : isComment = false;
                                    });
                                  },
                                  tabs: <Widget>[
                                    Tab(
                                      text: 'Thông tin',
                                    ),
                                    Tab(text: 'Bình luận'),
                                    Tab(text: 'Xem video'),
                                  ],
                                ),
                              ),
                              preferredSize: Size.fromHeight(48),
                            )),
                      )
                    ];
                  },
                  body: TabBarView(children: [
                    Builder(
                      builder: (context) {
                        return CustomScrollView(slivers: <Widget>[
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Text(
                                widget.data.title,
                                textAlign: TextAlign.center,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: PINK),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 52.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(
                                            widget.data.category,
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                        Text(
                                          '>',
                                          style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(
                                            widget.data.sub_category,
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                widget.data.date_time.toString().substring(
                                    0, widget.data.date_time
                                    .toString()
                                    .length - 7),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: data[index],
                                  );
                                },
                                childCount: data.length,
                              ),
                            ),
                          )
                        ]);
                      },
                    ),
                    CommentWidget(widget.data.docId, dataComment, currentUser, onLoadComment, onReplyComment),
                    PlayVideoWidget(linkVideo)
                  ]),
                )),
          ),
          Visibility(
            child: SafeArea(
              child: Container(
                height: 52,
                color: Colors.grey[100],
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 4,),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Type a comment...',
                        ),
                      ),
                    ),
                    SizedBox(width: 4,),
                    FlatButton(
                      onPressed: _insertComment,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: PINK,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4,),
                  ],
                ),
              ),
            ),
            visible: isComment,
          )
        ],
      ),
    );
  }

  void _insertComment() {
    if (currentUser != null) {
      if (_textEditingController.text != null) {
        if (isReplyComment) {
          addReplyComment();
          reply_comment.add(ReplyComment(
              _textEditingController.text,
              DateTime.now(),
              UserComment(
                currentUser.docId,
                currentUser.fullname,
                currentUser.avatar,
              )
          ).toJson());
          showDialogProgressLoading<bool>(
              context, _appBloc.insertCommentReply(widget.data.docId, idReplyComment,
              reply_comment)).then((value) {
            _textEditingController.clear();
            _getDataComment();
            setState(() {
              isReplyComment = false;
            });
            debugPrint('3');
          });
        } else {
          showDialogProgressLoading<bool>(
              context, _appBloc.insertComment(widget.data.docId, Comment(
              _textEditingController.text,
              DateTime.now(),
              [],
              UserComment(
                currentUser.docId,
                currentUser.fullname,
                currentUser.avatar,
              )
          ))).then((value) {
            _textEditingController.clear();
            _getDataComment();
          });
        }
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return SignInPage(check: true,);
      }));
    }
  }

  void addReplyComment() {
    reply_comment2.forEach((element) {
      reply_comment.add(element.toJson());
    });
  }

  void isLikePost() {
    widget.data?.like?.forEach((element) {
      if (element == currentUser?.docId) {
        setState(() {
          checked = true;
        });
      }
    });
  }

  void isSavePost() {
      currentUser?.save_post?.forEach((element) {
        if (element == widget.data?.docId) {
          setState(() {
            isSave = true;
            debugPrint('isSave: $isSave');
          });
        }
      });
  }

  int getLengthImage() {
    int length = 0;
    widget.data.content.forEach((element) {
      if (element.contains('image:')) {
        length++;
      }
    });
    return length;
  }

  void _getContent() {
    int count = 0;
    int lengthImage = getLengthImage();
    widget.data.content.forEach((element) {
      if (element.contains('content:') &&  ValidateUtils.isTitle(element.substring(8, element.length))) {
        data.add(Container(
          child: Text(
            element.substring(8, element.length),
            style: Theme
                .of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold, color: PINK),
          ),
        ));
      } else if (element.contains('content:')) {
        data.add(Container(
          child: Text(
            element.substring(8, element.length),
            style: Theme
                .of(context)
                .textTheme
                .subtitle2,
          ),
        ));
      }

      if (element.contains('video:') && element.length > 11) {
        setState(() {
          linkVideo = element.substring(element.length - 11, element.length);
        });
      }

      if (count < lengthImage) {
        data.add(ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Image.network(element.substring(6, element.length),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity, frameBuilder: (BuildContext context,
                  Widget child, int frame, bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return frame == null
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                )
                    : Image.network(
                  element.substring(6, element.length),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
        ));
      }
      count++;
    });
  }

  void likePost(bool isLiked) {
    developer.log('likePost ${widget.data.docId}', name: TAG);
    developer.log('likePost ${liked.length}', name: TAG);
    if (isLiked) {
      liked.add(_appBloc.currentUser.docId);
      showDialogProgressLoading<bool>(
          context, _appBloc.isLiked(liked, widget.data.docId))
          .then((value) {
        if (value) {
          isLikePost();
        }
      });
    } else {
      liked.remove(_appBloc.currentUser.docId);
      showDialogProgressLoading<bool>(
          context, _appBloc.isLiked(liked, widget.data.docId))
          .then((value) {
        if (value) {
          setState(() {
            checked = false;
          });
        }
      });
    }
    _appBloc.onLoad();
  }

  void savePost(bool isSaved) {
    if (isSaved) {
      saved.add(widget.data.docId);
      showDialogProgressLoading<bool>(
          context, _appBloc.saveStorage(currentUser.docId, saved))
          .then((value) {
        if (value) {
          isSavePost();
        }
      });
    } else {
      saved.remove(widget.data.docId);
      showDialogProgressLoading<bool>(
          context, _appBloc.saveStorage(currentUser.docId, saved))
          .then((value) {
        if (value) {
          setState(() {
            isSave = false;
          });
        }
      });
    }
    _appBloc.onLoad();
  }

  void _getDataComment() {
    _appBloc.getComment(widget.data.docId).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          dataComment = value;
          dataComment.forEach((element) {
              element.isReply = false;
          });
        });
      } else {
        setState(() {
          dataComment = [];
        });
      }
    });
  }


}

class InfoWithIconWidget extends StatelessWidget {
  final Widget icon;
  final dynamic info;
  final RichText richText;

  InfoWithIconWidget({this.icon, this.info, this.richText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: <Widget>[
          icon,
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: info != null ? Text(info.toString()) : richText,
              ))
        ],
      ),
    );
  }
}
