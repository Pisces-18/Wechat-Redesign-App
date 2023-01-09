import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wechat_redesign_app/data/vos/message_vo.dart';
import 'package:wechat_redesign_app/data/vos/moment_vo.dart';
import 'package:wechat_redesign_app/network/dataagents/wechat_data_agent.dart';

import '../../data/vos/user_vo.dart';

///Database Paths
const newsFeedPath="newsfeed";
const fileUploadRef="uploads";
const userPath="users";
const messagePath="contactsAndMessages";

class RealTimeDatabaseDataAgentImpl extends WechatDataAgent{
  static final RealTimeDatabaseDataAgentImpl _singleton= RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl(){
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  ///Database
  var databaseRef=FirebaseDatabase.instance.ref();

  ///Storage
  var firebaseStorage=FirebaseStorage.instance;

  ///Authentication
  FirebaseAuth auth=FirebaseAuth.instance;


  @override
  Stream<List<MomentVO>> getNewsFeed() {
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MomentVO>((element) {
        return MomentVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getNewsFeedById(int newsFeedId) {
    return databaseRef
        .child(newsFeedPath)
        .child(newsFeedId.toString())
        .once()
        .asStream()
        .map((snapShot) {
      return MomentVO.fromJson(Map<String,dynamic>.from(snapShot.snapshot.value as Map<dynamic,dynamic>));
    });
    //return Stream.value(NewsFeedVO());
  }

  @override
  Future<void> addNewPost(MomentVO newPost){
    return databaseRef
        .child(newsFeedPath)
        .child(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return databaseRef.child(newsFeedPath).child(postId.toString()).remove();
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser !=null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email,String password) {
    return auth.signInWithEmailAndPassword(email: email,password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) => credential.user?..updateDisplayName(newUser.userName))
        .then((user)  {
          newUser.id=user?.uid ?? "";
          _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser){
    return databaseRef
        .child(userPath)
        .child(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    // TODO: implement getMomentById
    throw UnimplementedError();
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    // TODO: implement getMoments
    throw UnimplementedError();
  }

  @override
  Future verifyPhoneNumber(String phoneNumber) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }

  @override
  Stream<UserVO> getUserByPhoneNumber(String phoneNumber) {
    return databaseRef
        .child(userPath)
        .child(phoneNumber)
        .once()
        .asStream()
        .map((snapShot) {
      return UserVO.fromJson(Map<String,dynamic>.from(snapShot.snapshot.value as Map<dynamic,dynamic>));
    });
  }

  @override
  Future<void> addContacts(String loggedInUserId, UserVO user) {
    // TODO: implement addContacts
    throw UnimplementedError();
  }

  @override
  Stream<UserVO> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Stream<List<UserVO>> getUserList(String userId) {
    // TODO: implement getUserList
    throw UnimplementedError();
  }

  @override
  Future<void> saveMessageFromLoginUser(String loggedInUserId, String receiverUserId, MessageVO message) {
    return databaseRef
        .child(messagePath)
        .child(loggedInUserId)
        .child(receiverUserId)
    .child(message.timeStamp?? "")
        .set(message.toJson());
  }

  @override
  Future<void> saveMessageFromReceiver(String loggedInUserId, String receiverUserId, MessageVO message) {
    return databaseRef
        .child(messagePath)
        .child(receiverUserId)
        .child(loggedInUserId)
        .child(message.timeStamp?? "")
        .set(message.toJson());
  }

  @override
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String receiverUserId) {
     return databaseRef.child(messagePath).child(loggedInUserId).child(receiverUserId).onValue.map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MessageVO>((element) {
        return MessageVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }


}