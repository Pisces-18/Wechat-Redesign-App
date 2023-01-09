// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      timeStamp: json['timeStamp'] as String?,
      useId: json['user_id'] as String?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      file: json['file'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'timeStamp': instance.timeStamp,
      'user_id': instance.useId,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'file': instance.file,
      'message': instance.message,
    };
