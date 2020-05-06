import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'timestamp_convert_datetime.dart';
part 'reply_comment.g.dart';

@JsonSerializable()
class ReplyComment {

  @JsonKey(
      ignore: true
  )
  String docId;

  String content;

  @TimestampConvertDatetime()
  DateTime date_time;

  String user_id_reply;


  ReplyComment(this.content, this.date_time, this.user_id_reply);

  factory ReplyComment.fromJson(Map<String, dynamic> json) => _$ReplyCommentFromJson(json);

   Map<String, dynamic> toJson() => _$ReplyCommentToJson(this);
 }