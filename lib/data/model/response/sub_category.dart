import 'package:json_annotation/json_annotation.dart';
part 'sub_category.g.dart';

@JsonSerializable()
class SubCategory {

  @JsonKey(
      ignore: true
  )
  String docId;

  String image;

  String name;


  SubCategory(this.image, this.name);

  factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);

   Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
 }