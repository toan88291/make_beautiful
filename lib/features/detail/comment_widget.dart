import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/resource/constant.dart';
import 'package:flutter_app_make_beautiful/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

import 'reply_comment_widget.dart';

class CommentWidget extends StatefulWidget {
  final String id;

  final List<Comment> dataComment;

  final SignInUser currentUser;

  final VoidCallback onLoadComment;

  final ValueChanged<Tuple3<bool, String, List<ReplyComment>>> onReplyComment;

  CommentWidget(this.id, this.dataComment, this.currentUser, this.onLoadComment,
      this.onReplyComment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  static final TAG = 'CommentWidget';

  AppBloc _appBloc;

  TextEditingController _textEditingController = TextEditingController();

  bool isReply = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBloc = Provider.of(context, listen: false);
    developer.log('didChangeDependencies id post: ${widget.currentUser?.docId}', name: TAG);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomScrollView(slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          widget.dataComment?.isNotEmpty && widget.dataComment != null
              ? SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: widget.dataComment[index].isReply
                                    ? Colors.pink[50]
                                    : Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey,
                                )),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                              ).copyWith(left: 4),
                              margin: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      widget.dataComment[index].user_comment
                                          .avatar,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      frameBuilder: (BuildContext context,
                                          Widget child,
                                          int frame,
                                          bool wasSynchronouslyLoaded) {
                                        if (wasSynchronouslyLoaded) {
                                          return child;
                                        }
                                        return frame == null
                                            ? Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
                                                child: Container(
                                                  height: 48,
                                                  width: 48,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 24,
                                                backgroundImage: NetworkImage(
                                                    widget.dataComment[index]
                                                        .user_comment.avatar),
                                              );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: Text(
                                                    widget.dataComment[index]
                                                        .user_comment.fullname,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: Text(
                                                    widget.dataComment[index]
                                                        .date_time
                                                        .toString()
                                                        .substring(0, 11),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            widget.dataComment[index].content,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.dataComment[index]
                                                          .isReply =
                                                      !widget.dataComment[index]
                                                          .isReply;
                                                });
                                                widget.onReplyComment(Tuple3(
                                                    widget.dataComment[index]
                                                        .isReply,
                                                    widget.dataComment[index]
                                                        .docId,
                                                    widget.dataComment[index]
                                                        .reply_comment));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Text(
                                                  'Reply',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                        color: widget
                                                                .dataComment[
                                                                    index]
                                                                .isReply
                                                            ? PINK
                                                            : Colors.black,
                                                        fontWeight: widget
                                                                .dataComment[
                                                                    index]
                                                                .isReply
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialogProgressLoading(
                                                        context,
                                                        _appBloc.deleteComment(
                                                            widget.id,
                                                            widget
                                                                .dataComment[
                                                                    index]
                                                                .docId))
                                                    .then((value) {
                                                  widget.onLoadComment();
                                                });
                                              },
                                              child: Visibility(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                visible: widget
                                                            .dataComment[index]
                                                            .user_comment
                                                            .id ==
                                                        widget.currentUser
                                                            ?.docId ,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              child: Container(
                                margin: EdgeInsets.only(left: 32.0),
                                child: Column(
                                  children: showCommentReply(index),
                                ),
                              ),
                              visible: widget
                                      .dataComment[index].reply_comment.length >
                                  0,
                            )
                          ],
                        );
                      },
                      childCount: widget.dataComment?.length ?? 0,
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Chưa có bình luận nào .',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                )
        ]);
      },
    );
  }

  List<Widget> showCommentReply(int index) {
    List<Widget> datas = [];
    if (widget.dataComment.isNotEmpty) {
      widget.dataComment[index]?.reply_comment?.forEach((element) {
        datas.add(ReplyCommentWidget(
          element,
          widget.currentUser?.docId,
          widget.dataComment[index]?.reply_comment,
          widget.currentUser,
          widget.onLoadComment,
          Tuple2<String,String>(widget.id,widget.dataComment[index]?.docId),
        ));
      });
    }
    return datas;
  }
}
