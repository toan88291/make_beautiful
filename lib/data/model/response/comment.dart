import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_make_beautiful/data/model/response/user_comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'reply_comment.dart';
import 'timestamp_convert_datetime.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {

  @JsonKey(
      ignore: true
  )
  String docId;

  bool isReply = false;

  String content;

  @TimestampConvertDatetime()
  DateTime date_time;

  List<ReplyComment> reply_comment;

  UserComment user_comment;

  Comment(this.content, this.date_time, this.reply_comment,
      this.user_comment);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

   Map<String, dynamic> toJson() => _$CommentToJson2(this);

  Map<String, dynamic> _$CommentToJson2(Comment instance) => <String, dynamic>{
    'content': instance.content,
    'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
    'reply_comment': instance.reply_comment.toList(),
    'user_comment': instance.user_comment.toJson(),
  };
 }