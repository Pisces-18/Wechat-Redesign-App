import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';

class LoginBloc extends ChangeNotifier{
///State
  String email = "";
  String password = "";
  bool isDisposed = false;
  bool isLoading = false;
  //String email="";

  ///Model
  final AuthenticationModel _model = AuthenticationModelImpl();
  WechatModel _wechatModel = WechatModelImpl();

  Future onTapLogin() {
    //_showLoading();
    // _wechatModel.getUserByPhoneNumber("+959758347723").listen((user) {
    //   email=user.email?? "";
    //   debugPrint("User email ===>$email");
    //   _notifysafely();
    // });
    return _model.login(email,password).whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void _showLoading() {
    isLoading = true;
    _notifysafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifysafely();
  }

  void _notifysafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}