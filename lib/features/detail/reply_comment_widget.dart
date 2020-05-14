import 'package:flutter/material.dart';
import 'package:flutter_app_make_beautiful/data/model/response/reply_comment.dart';
import 'package:flutter_app_make_beautiful/widget/show_dialog_loading.dart';
import 'package:shimmer/shimmer.dart';

class ReplyCommentWidget extends StatelessWidget {
  final ReplyComment data;

  final String docId;

  ReplyCommentWidget(this.data, this.docId);

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
//                      showDialogProgressLoading(
//                          context,
//                          _appBloc.deleteComment(widget.id,
//                              widget.dataComment[index].docId))
//                          .then((value) {
//                        widget.onLoadComment();
//                      });
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
                          visible: data.user_reply.id == docId,
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
}
