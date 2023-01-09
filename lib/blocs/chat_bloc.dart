import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';
import '../data/vos/user_vo.dart';

class ChatBloc extends ChangeNotifier{
  List<UserVO>? contactList;
  String? userId;
  bool isDisposed = false;
  UserVO? receiver;
  UserVO? sender;

  ///Model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();
  final WechatModel _wechatModel=WechatModelImpl();

  ChatBloc(){
    userId=_mAuthenticationModel.getLoggedInUser().id;
    _wechatModel.getUserList(userId?? "").listen((contacts) {
      contactList=contacts;
      debugPrint("Contacts ====>${contactList?.first.userName}");
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get User List Error====>$error");
    });
  }
  Future onTapChat(String receiverId){
    userId=_mAuthenticationModel.getLoggedInUser().id;
    _wechatModel.getUserById(userId?? "").listen((user) {
      sender=user;
      debugPrint("Get Sender Data====>${sender?.userName}");

      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get Sender Data Error ====>$error");
    });

    _wechatModel.getUserById(receiverId).listen((user) {
      receiver=user;
      debugPrint("Get Receiver Data ====>${receiver?.userName}");

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