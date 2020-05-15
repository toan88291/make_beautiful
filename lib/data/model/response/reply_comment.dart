import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_make_beautiful/data/model/response/user_comment.dart';
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

  UserComment user_reply;

  ReplyComment(this.content, this.date_time, this.user_reply);

  factory ReplyComment.fromJson(Map<String, dynamic> json) => _$ReplyCommentFromJson(json);

   Map<String, dynamic> toJson() => _$ReplyCommentToJson2(this);

  Map<String, dynamic> _$ReplyCommentToJson2(ReplyComment instance) =>
      <String, dynamic>{
        'content': instance.content,
        'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
        'user_reply': instance.user_reply.toJson(),
      };
 }