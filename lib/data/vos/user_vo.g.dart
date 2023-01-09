// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'profile_picture': instance.profilePicture,
    };
