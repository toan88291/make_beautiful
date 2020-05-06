import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {

  @JsonKey(
      ignore: true
  )
  String docId;

  String icon;

  String name;

  Category(this.icon, this.name);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

   Map<String, dynamic> toJson() => _$CategoryToJson(this);
 }