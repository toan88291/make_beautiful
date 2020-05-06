import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'timestamp_convert_datetime.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {

  @JsonKey(
      ignore: true
  )
  String docId;

  String category;

  String category_id;

  List<String> content;

  List<String> like;

  String sub_category;

  String sub_category_id;

  String thumb;

  String title;

  String user_id;

  @TimestampConvertDatetime()
  DateTime date_time;

  Post(this.category, this.sub_category, this.category_id,
      this.thumb, this.content, this.like, this.sub_category_id,
      this.title, this.user_id, this.date_time);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

   Map<String, dynamic> toJson() => _$PostToJson2(this);

  Map<String, dynamic> _$PostToJson2(Post instance) => <String, dynamic>{
    'category': instance.category,
    'category_id': instance.category_id,
    'content': instance.content.toList(),
    'like': instance.like.toList(),
    'sub_category': instance.sub_category,
    'sub_category_id': instance.sub_category_id,
    'thumb': instance.thumb,
    'title': instance.title,
    'user_id': instance.user_id,
    'date_time': const TimestampConvertDatetime().toJson(instance.date_time),
  };
 }