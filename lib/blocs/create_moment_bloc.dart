import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign_app/data/models/wechat_model_impl.dart';
import 'package:wechat_redesign_app/data/vos/moment_vo.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/vos/user_vo.dart';

class CreateMomentBloc extends ChangeNotifier{
  ///State
  String newPostDescription="";
  bool isAddNewPostError=false;
  bool isDisposed=false;
  bool isLoading=false;
  UserVO? _loggedInUser;

  ///Image
  File? chosenImageFile;

  ///For Edit Mode
  bool isInEditMode=false;
  String userName="";
  String profilePicture="";
  MomentVO? mMoment;

  ///Model
  final WechatModel _model=WechatModelImpl();
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();


  CreateMomentBloc({int? momentId}){
    _loggedInUser=_mAuthenticationModel.getLoggedInUser();
    if(momentId != null){
      isInEditMode=true;
      _prepopulateDataForEditMode(momentId);
    }else{
      _prepopulateDataForAddNewPost();
    }
  }

  void _prepopulateDataForAddNewPost(){
    debugPrint("User Name===>${_loggedInUser?.userName ?? ""}");

    userName=_loggedInUser?.userName ?? "";
    profilePicture="";
    _notifysafely();
  }

  void _prepopulateDataForEditMode(int momentId){
    _model.getMomentById(momentId).listen((moment) {
      userName=moment.userName ?? "";
      profilePicture=moment.profilePicture ?? "";
      newPostDescription=moment.description ?? "";
      mMoment=moment;
      _notifysafely();
    }).onError((error){
      debugPrint("Edit Error===>$error");
    });
  }

  void onNewPostTextChanged(String newPostDescription){
    this.newPostDescription=newPostDescription;
  }

  Future onTapAddNewPost(){
    if(newPostDescription.isEmpty){
      isAddNewPostError=true;
      _notifysafely();
      return Future.error("Error");
    }else{
      isLoading=true;
      _notifysafely();
      isAddNewPostError=false;
      if(isInEditMode){
        return _editMomentPost().then((value){
          isLoading=false;
          _notifysafely();
        });
      }else{
        return _createNewMomentPost().then((value){
          isLoading=false;
          _notifysafely();
        });
      }
    }
  }


  Future<dynamic> _editMomentPost(){
    mMoment?.description=newPostDescription;
    if(mMoment !=null){
      return _model.editPost(mMoment!);
    }else{
      return Future.error("Error");
    }
  }

  Future<void> _createNewMomentPost(){
    return _model.addNewPost(newPostDescription,chosenImageFile);
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