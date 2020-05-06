import 'package:json_annotation/json_annotation.dart';
part 'sign_in_user.g.dart';

@JsonSerializable()
class SignInUser {

  @JsonKey(
      ignore: true
  )
  String docId;

  String avatar;

  String fullname;

  String password;

  bool role;

  List<String> save_post;

  String username;

  SignInUser(this.avatar, this.fullname, this.password, this.role,
      this.save_post, this.username);

  factory SignInUser.fromJson(Map<String, dynamic> json) => _$SignInUserFromJson(json);

   Map<String, dynamic> toJson() => _$SignInUserToJson(this);
 }