import 'package:flutter/material.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';

class SignUpBloc extends ChangeNotifier{
  ///State
  bool isLoading=false;
  String email="";
  String password="";
  String userName="";
  bool isDisposed=false;

  ///Model
  final AuthenticationModel _model=AuthenticationModelImpl();

  Future onTapSignUp(String phoneNumber){
    _showLoading();
    return _model
        .register("+959${phoneNumber}", email,userName, password)
        .whenComplete(() => _hideLoading());
  }

  Future onTapLogin(String phoneNumber) {
    _showLoading();
    return _model.login(email,password).whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email){
    this.email=email;
  }

  void onPasswordChanged(String password){
    this.password=password;
  }

  void onUserNameChanged(String userName){
    this.userName=userName;
  }

  void _showLoading(){
    isLoading=true;
    _notifysafely();
  }

  void _hideLoading(){
    isLoading=false;
    _notifysafely();
  }

  void _notifysafely(){
    if(!isDisposed){
      notifyListeners();
    }
  }

  @override
  void dispose(){
    super.dispose();
    isDisposed=true;
  }
}