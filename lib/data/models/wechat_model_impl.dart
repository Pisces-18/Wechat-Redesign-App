import 'dart:io';

import 'package:wechat_redesign_app/data/models/wechat_model.dart';
import 'package:wechat_redesign_app/data/vos/message_vo.dart';
import 'package:wechat_redesign_app/data/vos/moment_vo.dart';
import 'package:wechat_redesign_app/data/vos/user_vo.dart';
import 'package:wechat_redesign_app/network/dataagents/wechat_data_agent.dart';

import '../../network/dataagents/cloud_firestore_data_agent_impl.dart';
import '../../network/dataagents/real_time_database_data_agent_impl.dart';
import 'authentication_model.dart';
import 'authentication_model_Impl.dart';

class WechatModelImpl extends WechatModel {
  static final WechatModelImpl _singleton = WechatModelImpl._internal();

  factory WechatModelImpl() {
    return _singleton;
  }

  WechatModelImpl._internal();

  ///Data Agent
  WechatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();
  WechatDataAgent mRealTimeDataAgent = RealTimeDatabaseDataAgentImpl();

  ///Authentication Model
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Future<void> addNewPost(String description, File? imageFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftMomentVO(description, downloadUrl))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else {
      return craftMomentVO(description, "")
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  Future<MomentVO> craftMomentVO(String description, String imageUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = MomentVO(
        id: currentMilliseconds,
        description: description,
        userName: _authenticationModel.getLoggedInUser().userName,
        postImages: "",
        profilePicture: '');
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> editPost(MomentVO moment) {
    return mDataAgent.addNewPost(moment);
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    return mDataAgent.getMoments();
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  @override
  Stream<UserVO> getUserByPhoneNumber(String phoneNumber) {
    return mDataAgent.getUserByPhoneNumber(phoneNumber);
  }

  @override
  Stream<UserVO> getUserById(String userId) {
    return mDataAgent.getUserById(userId);
  }

  @override
  Future<void> addContacts(String loggedInUserId, UserVO user) {
    return mDataAgent.addContacts(loggedInUserId, user);
  }

  @override
  Stream<List<UserVO>> getUserList(String userId) {
    return mDataAgent.getUserList(userId);
  }

  @override
  Future<void> saveMessages(
    UserVO loggedInUser,
    String receiverUserId,
    String message,
  ) {
    return craftMessageVO(message, loggedInUser.userName ?? "",
            loggedInUser.id ?? "", loggedInUser.profilePicture ?? "")
        .then((newMessage){
      mRealTimeDataAgent.saveMessageFromLoginUser(
          loggedInUser.id ?? "", receiverUserId, newMessage);
      mRealTimeDataAgent.saveMessageFromReceiver(
          loggedInUser.id ?? "", receiverUserId, newMessage);
    });
  }


  Future<MessageVO> craftMessageVO(
      String message, String name, String id, String profilePicture) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newMessage = MessageVO(
        timeStamp: currentMilliseconds.toString(),
        useId: id,
        name: name,
        profilePicture: profilePicture,
        file: '',
        message: message);
    return Future.value(newMessage);
  }

  @override
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String receiverUserId) {
    return mRealTimeDataAgent.getMessages(loggedInUserId, receiverUserId);
  }
}
