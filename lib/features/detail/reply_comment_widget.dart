import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/bloc/app_bloc.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/data/model/response/sign_in_user.dart';
import 'package:flutter_app_make_beautiful/widget/show_dialog_loading.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

class ReplyCommentWidget extends StatelessWidget {
  final ReplyComment data;

  final String docId;

  final List<ReplyComment> dataComment;

  final SignInUser currentUser;

  final VoidCallback onLoadComment;

  final Tuple2<String,String> idDelete;

  List<Map<String,dynamic>> dataCommentMap = [];

  ReplyCommentWidget(this.data, this.docId, this.dataComment, this.currentUser,this.onLoadComment,this.idDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border(
              bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ))),
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ).copyWith(left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              data.user_reply?.avatar,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              frameBuilder: (BuildContext context, Widget child, int frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return frame == null
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
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
                      data.user_reply.avatar,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            data.user_reply?.fullname ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            data?.date_time.toString().substring(0, 11) ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.grey),
                          ),
                        )
                      ],
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          data?.content ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          debugPrint('data : ${dataComment.length}');
                          dataComment.remove(data);
                          debugPrint('data 2: ${dataComment.length}');
                          debugPrint('id post: ${idDelete.item1}');
                          debugPrint('id comment: ${idDelete.item2}');
                          loadMapComment();
                          showDialogProgressLoading<bool>(
                              context, Provider.of<AppBloc>(context,listen: false).insertCommentReply(idDelete.item1, idDelete.item2,
                              dataCommentMap)).then((value) {
                            onLoadComment();
                          });
                        },
                        child: Visibility(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          visible: data.user_reply.id == docId || currentUser.role,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadMapComment() {
    dataComment.forEach((element) {
      dataCommentMap.add(element.toJson());
    });
  }
}
