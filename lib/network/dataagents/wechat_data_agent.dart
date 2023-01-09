import 'dart:io';

import 'package:wechat_redesign_app/data/vos/moment_vo.dart';

import '../../data/vos/message_vo.dart';
import '../../data/vos/user_vo.dart';

abstract class WechatDataAgent{
  ///News Feed
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(MomentVO newPost);
  Future<void> deletePost(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<String> uploadFileToFirebase(File image);

  ///Authentication
  Future verifyPhoneNumber(String phoneNumber);
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();
  Stream<UserVO> getUserByPhoneNumber(String phoneNumber);

  ///Contacts
  Stream<UserVO> getUserById(String userId);
  Future<void> addContacts(String loggedInUserId,UserVO user);
  Stream<List<UserVO>> getUserList(String userId);

  ///Chats
  Future<void> saveMessageFromLoginUser(String loggedInUserId,String receiverUserId,MessageVO message);
  Future<void> saveMessageFromReceiver(String loggedInUserId,String receiverUserId,MessageVO message);
  Stream<List<MessageVO>> getMessages(String loggedInUserId,String receiverUserId,);
}