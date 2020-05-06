import 'package:cloud_firestore/cloud_firestore.dart';
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

  String content;

  @TimestampConvertDatetime()
  DateTime date_time;

  List<ReplyComment> reply_comment;

  String user_id;

  Comment(this.content, this.date_time, this.reply_comment,
      this.user_id);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

   Map<String, dynamic> toJson() => _$CommentToJson2(this);

  Map<String, dynamic> _$CommentToJson2(Comment instance) => <String, dynamic>{
    'content': instance.content,
    'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
    'reply_comment': instance.reply_comment.toList(),
    'user_id': instance.user_id,
  };
 }