import 'dart:io';

import 'package:wechat_redesign_app/data/vos/moment_vo.dart';

import '../vos/message_vo.dart';
import '../vos/user_vo.dart';

abstract class WechatModel{
  Stream<List<MomentVO>> getMoments();
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> addNewPost(String description,File? imageFile);
  Future<void> deletePost(int postId);
  Future<void> editPost(MomentVO moment);
  Stream<UserVO> getUserByPhoneNumber(String phoneNumber);

  ///Contact
  Stream<UserVO> getUserById(String userId);
  Future<void> addContacts(String loggedInUserId,UserVO user);
  Stream<List<UserVO>> getUserList(String userId);

  ///Chats
  Future<void> saveMessages(UserVO loggedInUser,String receiverUserId,String message);
  Stream<List<MessageVO>> getMessages(String loggedInUserId,String receiverUserId,);


}