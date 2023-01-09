import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';
import '../data/vos/user_vo.dart';

class QrBloc extends ChangeNotifier{
  UserVO? scannedUser;
  UserVO? loggedInUser;
  String? loggedInUserId;

  bool isDisposed = false;

  ///Model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();
  final WechatModel _wechatModel=WechatModelImpl();

  Future scannedQr(String userId)async{
    if(userId.isNotEmpty){
      loggedInUserId=_mAuthenticationModel.getLoggedInUser().id;
      _wechatModel.getUserById(loggedInUserId?? "").listen((user) {
        loggedInUser=user;
        if (!isDisposed) {
          notifyListeners();

        }
      });
      _wechatModel.getUserById(userId).listen((user) {
        scannedUser=user;
        if (!isDisposed) {
          notifyListeners();

        }
      }).onError((error){
        debugPrint("Get User Error$error");
      });
    }
    if(scannedUser !=null && loggedInUser !=null){
      _wechatModel.addContacts(loggedInUserId?? "", scannedUser!).then((value){
        debugPrint("Add Contacts Successfully");
        _wechatModel.addContacts(scannedUser?.id?? "", loggedInUser!);
      }).catchError((error){
        debugPrint("Add Contacts Error====>$error");
      });

    }
    return Future.value("Error");

  }
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}