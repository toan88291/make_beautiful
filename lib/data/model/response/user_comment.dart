import 'package:json_annotation/json_annotation.dart';
part 'user_comment.g.dart';

@JsonSerializable()
class UserComment {

  String id;

  String fullname;

  String avatar;

  UserComment(this.id, this.fullname, this.avatar);

  factory UserComment.fromJson(Map<String, dynamic> json) => _$UserCommentFromJson(json);

   Map<String, dynamic> toJson() => _$UserCommentToJson(this);
 }