import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';
import '../data/vos/user_vo.dart';

class MeBloc extends ChangeNotifier{
  UserVO? loggedInUser;
  String? userId;
  bool isDisposed = false;

  ///model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();
  final WechatModel _wechatModel=WechatModelImpl();


  MeBloc(){
    userId=_mAuthenticationModel.getLoggedInUser().id;
    _wechatModel.getUserById(userId ?? "").listen((user) {
      loggedInUser=user;
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get User Error$error");
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}