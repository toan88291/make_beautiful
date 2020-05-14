// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyComment _$ReplyCommentFromJson(Map<String, dynamic> json) {
  return ReplyComment(
    json['content'] as String,
    const TimestampConvertDatetime().fromJson(json['date_time'] as Timestamp),
    json['user_reply'] == null
        ? null
        : UserComment.fromJson(json['user_reply'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReplyCommentToJson(ReplyComment instance) =>
    <String, dynamic>{
      'content': instance.content,
      'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
      'user_id_reply': instance.user_reply,
    };
