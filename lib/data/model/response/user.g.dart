// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
    json['password'] as String,
    json['fullname'] as String,
    json['role'] as bool,
    json['avatar'] as String,
    (json['save_post'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'role': instance.role,
      'save_post': instance.savePost,
    };
