// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['content'] as String,
    const TimestampConvertDatetime().fromJson(json['date_time'] as Timestamp),
    (json['reply_comment'] as List)
        ?.map((e) =>
            e == null ? null : ReplyComment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['user_id'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'content': instance.content,
      'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
      'reply_comment': instance.reply_comment,
      'user_id': instance.user_id,
    };
