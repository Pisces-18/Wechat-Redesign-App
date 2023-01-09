import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';

class SettingBloc extends ChangeNotifier{
///model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();

  Future onTapLogout(){
    return _mAuthenticationModel.logOut();
  }
}