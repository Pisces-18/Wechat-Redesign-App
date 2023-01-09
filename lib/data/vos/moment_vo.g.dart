// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as int?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      postImages: json['post_image'] as String?,
      postedTime: json['posted_time'] as String?,
      reactedCount: json['reacted_count'] as int?,
      commentedCount: json['commented_count'] as int?,
      isSaved: json['is_saved'] as bool? ?? false,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'post_image': instance.postImages,
      'posted_time': instance.postedTime,
      'reacted_count': instance.reactedCount,
      'commented_count': instance.commentedCount,
      'is_saved': instance.isSaved,
    };
