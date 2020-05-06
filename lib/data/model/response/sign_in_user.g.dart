// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInUser _$SignInUserFromJson(Map<String, dynamic> json) {
  return SignInUser(
    json['avatar'] as String,
    json['fullname'] as String,
    json['password'] as String,
    json['role'] as bool,
    (json['save_post'] as List)?.map((e) => e as String)?.toList(),
    json['username'] as String,
  );
}

Map<String, dynamic> _$SignInUserToJson(SignInUser instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'fullname': instance.fullname,
      'password': instance.password,
      'role': instance.role,
      'save_post': instance.save_post,
      'username': instance.username,
    };
