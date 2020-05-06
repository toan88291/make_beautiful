// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['category'] as String,
    json['sub_category'] as String,
    json['category_id'] as String,
    json['thumb'] as String,
    (json['content'] as List)?.map((e) => e as String)?.toList(),
    (json['like'] as List)?.map((e) => e as String)?.toList(),
    json['sub_category_id'] as String,
    json['title'] as String,
    json['user_id'] as String,
    const TimestampConvertDatetime().fromJson(json['date_time'] as Timestamp),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'category': instance.category,
      'category_id': instance.category_id,
      'content': instance.content,
      'like': instance.like,
      'sub_category': instance.sub_category,
      'sub_category_id': instance.sub_category_id,
      'thumb': instance.thumb,
      'title': instance.title,
      'user_id': instance.user_id,
      'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
    };
