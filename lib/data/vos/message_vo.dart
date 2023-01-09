import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "timeStamp")
  String? timeStamp;

  @JsonKey(name: "user_id")
  String? useId;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "file")
  String? file;

  @JsonKey(name: "message")
  String? message;

  MessageVO(
      {this.timeStamp,
      this.useId,
      this.name,
      this.profilePicture,
      this.file,
      this.message});

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
