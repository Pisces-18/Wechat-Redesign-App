import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign_app/data/vos/message_vo.dart';
import 'package:wechat_redesign_app/data/vos/moment_vo.dart';
import 'package:wechat_redesign_app/data/vos/user_vo.dart';
import 'package:wechat_redesign_app/network/dataagents/wechat_data_agent.dart';

///News Feed Collection
const momentsCollection = "moments";
const fileUploadRef = "uploads";
const usersCollection = "users";
const contactsCollection="contacts";

///Authentication
FirebaseAuth auth = FirebaseAuth.instance;

class CloudFireStoreDataAgentImpl extends WechatDataAgent {
  ///FireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> addNewPost(MomentVO newPost) {
    return _fireStore
        .collection(momentsCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(momentsCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    return _fireStore
        .collection(momentsCollection)
        .snapshots()
        .map((querySnapshot){
      return querySnapshot.docs.map<MomentVO>((document){
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return _fireStore
        .collection(momentsCollection)
        .doc(momentId.toString())
        .get()
        .asStream()
        .where((documentSnapshot) => documentSnapshot.data() != null)
        .map((documentSnapshot) => MomentVO.fromJson(documentSnapshot.data()!));
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
      phoneNumber: auth.currentUser?.phoneNumber,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email,String password) {
    debugPrint("Email===>$email");
    debugPrint("Password===>$password");
    return auth.signInWithEmailAndPassword(email: email,password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    debugPrint("Email===>${newUser.email}");
    debugPrint("Password===>${newUser.password}");
    return auth
        .createUserWithEmailAndPassword(email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) => credential.user?..updateDisplayName(newUser.userName))
        .then((user)  {
      newUser.id=user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return _fireStore
        .collection(usersCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future verifyPhoneNumber(String phoneNumber) {
    debugPrint("Phone====>$phoneNumber");
    return auth.verifyPhoneNumber(
        phoneNumber: "+959689583719",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          debugPrint("verification completed ${phoneAuthCredential.smsCode}");
          await auth.signInWithCredential(phoneAuthCredential);
          //User? user = FirebaseAuth.instance.currentUser;
          // if(phoneAuthCredential.smsCode != null){
          //   await auth.signInWithCredential(phoneAuthCredential).
          //   then((credential) => credential.user?..updateDisplayName(newUser.userName))
          //       .then((user){
          //     newUser.id=user?.uid ?? "";
          //     _addNewUser(newUser);
          //   });
          // }
        },
        verificationFailed: (FirebaseAuthException error) {
          debugPrint("Authentication Error ====>$error");
          if (error.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) async{
          String smsCode = 'xxxx';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Stream<UserVO> getUserByPhoneNumber(String phoneNumber) {
    return _fireStore
        .collection(usersCollection)
        .doc(phoneNumber)
        .get()
        .asStream()
        .where((documentSnapshot) => documentSnapshot.data() != null)
        .map((documentSnapshot) => UserVO.fromJson(documentSnapshot.data()!));
  }


  @override
  Stream<UserVO> getUserById(String userId) {
    return _fireStore
        .collection(usersCollection)
        .doc(userId.toString())
        .get()
        .asStream()
        .where((documentSnapshot) => documentSnapshot.data() != null)
        .map((documentSnapshot) => UserVO.fromJson(documentSnapshot.data()!));
  }

  @override
  Future<void> addContacts(String loggedInUserId,UserVO user) {
    return _fireStore
        .collection(usersCollection)
        .doc(loggedInUserId)
        .collection(contactsCollection)
        .doc(user.id)
        .set(user.toJson());
  }

  @override
  Stream<List<UserVO>> getUserList(String userId) {
    return _fireStore
    .collection(usersCollection)
        .doc(userId)
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapshot){
      return querySnapshot.docs.map<UserVO>((document){
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> saveMessageFromLoginUser(String loggedInUserId, String receiverUserId, MessageVO message) {
    // TODO: implement saveMessageFromLoginUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveMessageFromReceiver(String loggedInUserId, String receiverUserId, MessageVO message) {
    // TODO: implement saveMessageFromReceiver
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageVO>> getMessages(String loggedInUserId, String receiverUserId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }



}
