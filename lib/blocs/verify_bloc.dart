import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';

class VerifyBloc extends ChangeNotifier{
  ///State
  bool isLoading=false;
  String phoneNumber="";

  ///Model
  final AuthenticationModel _model=AuthenticationModelImpl();

  void onPhoneNumberChange(String phoneNumber){
    this.phoneNumber=phoneNumber;
  }

  void getOtp(){
    _model.verifyPhoneNumber(phoneNumber);
  }

}