import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';
import '../data/vos/user_vo.dart';

class ContactsBloc extends ChangeNotifier{
  List<UserVO>? contactList;
  String? userId;
  UserVO? receiver;
  UserVO? sender;
  bool isDisposed = false;

  ///Model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();
  final WechatModel _wechatModel=WechatModelImpl();

  ContactsBloc(){
    userId=_mAuthenticationModel.getLoggedInUser().id;
    _wechatModel.getUserList(userId?? "").listen((contacts) {
      contactList=contacts;
      debugPrint("Contacts ====>$contactList");
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get User List Error====>$error");
    });
  }

  Future onTapContact(String receiverId){
    userId=_mAuthenticationModel.getLoggedInUser().id;
    _wechatModel.getUserById(userId?? "").listen((user) {
      sender=user;
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get Sender Data Error====>$error");
    });

    _wechatModel.getUserById(receiverId).listen((user) {
      receiver=user;
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get Sender Data Error====>$error");
    });

    return Future.value("Error");
  }
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}