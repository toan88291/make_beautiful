// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpUser _$SignUpUserFromJson(Map<String, dynamic> json) {
  return SignUpUser(
    json['avatar'] as String,
    json['fullname'] as String,
    json['password'] as String,
    json['role'] as bool,
    (json['save_post'] as List)?.map((e) => e as String)?.toList(),
    json['username'] as String,
  );
}

Map<String, dynamic> _$SignUpUserToJson(SignUpUser instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'fullname': instance.fullname,
      'password': instance.password,
      'role': instance.role,
      'save_post': instance.save_post,
      'username': instance.username,
    };
