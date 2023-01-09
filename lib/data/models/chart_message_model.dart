import 'package:flutter/cupertino.dart';

class ChatMessageModel{
  String? messageContent;
  DateTime? date;
  bool? isSendByMe;
  ChatMessageModel({@required this.messageContent, @required this.date, @required this.isSendByMe});
}