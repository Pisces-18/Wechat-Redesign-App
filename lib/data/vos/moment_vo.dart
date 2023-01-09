import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';
@JsonSerializable()
class MomentVO{
  @JsonKey(name : "id")
  int? id;

  @JsonKey(name : "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name : "post_image")
  String? postImages;

  @JsonKey(name: "posted_time")
  String? postedTime;

  @JsonKey(name: "reacted_count")
  int? reactedCount;

  @JsonKey(name: "commented_count")
  int? commentedCount;

  @JsonKey(name: "is_saved")
  bool isSaved=false;

  MomentVO(
      {this.id,
      this.description,
      this.profilePicture,
      this.userName,
      this.postImages,
      this.postedTime,
      this.reactedCount,
      this.commentedCount,
       this.isSaved=false});

  factory MomentVO.fromJson(Map<String,dynamic> json)=>_$MomentVOFromJson(json);

  Map<String,dynamic> toJson() => _$MomentVOToJson(this);
}