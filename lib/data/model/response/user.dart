import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  @JsonKey(
      ignore: true
  )
  String docId;

  String username;

  String password;

  String fullname;

  String avatar;

  bool role;

  @JsonKey(
      name: 'save_post'
  )
  List<String> savePost;


  User(this.username, this.password, this.fullname, this.role, this.avatar, this.savePost);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   Map<String, dynamic> toJson() => _$UserToJson2(this);

  Map<String, dynamic> _$UserToJson2(User instance) => <String, dynamic>{
    'username': instance.username,
    'password': instance.password,
    'fullname': instance.fullname,
    'avatar': instance.avatar,
    'role': instance.role,
    'save_post': instance.savePost.toList() ,
  };

 }