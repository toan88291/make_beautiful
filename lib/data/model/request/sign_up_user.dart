import 'package:json_annotation/json_annotation.dart';
part 'sign_up_user.g.dart';

@JsonSerializable()
class SignUpUser {

  String avatar;

  String fullname;

  String password;

  bool role;

  List<String> save_post;

  String username;


  SignUpUser(this.avatar, this.fullname, this.password, this.role,
      this.save_post, this.username);

  factory SignUpUser.fromJson(Map<String, dynamic> json) => _$SignUpUserFromJson(json);

   Map<String, dynamic> toJson() => _$SignUpUserToJson2(this);

  Map<String, dynamic> _$SignUpUserToJson2(SignUpUser instance) =>
      <String, dynamic>{
        'avatar': instance.avatar,
        'fullname': instance.fullname,
        'password': instance.password,
        'role': instance.role,
        'save_post': instance.save_post.toList(),
        'username': instance.username,
      };
 }