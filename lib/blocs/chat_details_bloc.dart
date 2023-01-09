import 'package:flutter/cupertino.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_Impl.dart';
import '../data/models/wechat_model.dart';
import '../data/models/wechat_model_impl.dart';
import '../data/vos/message_vo.dart';
import '../data/vos/user_vo.dart';

class ChatDetailsBloc extends ChangeNotifier{
  UserVO? receiverUser;
  UserVO? senderUser;
  String? senderId;
  String? receiverId;
  String? message;
  List<MessageVO> messages=[];
  bool isDisposed = false;

  ///Model
  final AuthenticationModel _mAuthenticationModel=AuthenticationModelImpl();
  final WechatModel _wechatModel=WechatModelImpl();

  ChatDetailsBloc( UserVO sender,UserVO receiver){
    senderUser=sender;
    receiverUser=receiver;
    // senderId=_mAuthenticationModel.getLoggedInUser().id;
    // _wechatModel.getUserById(senderId?? "").listen((user) {
    //   sender=user;
    //   if (!isDisposed) {
    //     notifyListeners();
    //   }
    // }).onError((error){
    //   debugPrint("Get Sender Data Error====>$error");
    // });
    //
    // _wechatModel.getUserById(receiverId).listen((user) {
    //   receiver=user;
    //   if (!isDisposed) {
    //     notifyListeners();
    //   }
    // }).onError((error){
    //   debugPrint("Get Sender Data Error====>$error");
    // });

    _getMessage(sender,receiver);

  }

  Future onTapSendMessage(){
    if(message !=null && senderUser !=null && receiverUser !=null){
      return _wechatModel.saveMessages(senderUser!, receiverUser?.id ?? "", message?? "").then((value){
        _getMessage(senderUser!,receiverUser!);
        message="";
        if (!isDisposed) {
          notifyListeners();
        }
      });

    }
    return Future.error("Error");

  }

  void _getMessage(UserVO sender,UserVO receiver){
    _wechatModel.getMessages(sender.id ?? "", receiver.id?? "").listen((data) {
      data.sort((a,b)=>int.parse(a.timeStamp ?? "").compareTo(int.parse(b.timeStamp ?? "")));
      messages=data;
      debugPrint("Get Message Data ====>${messages}");

      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get Message Data Error====>$error");
    });
  }

  void onMessageChanged(String message) {
    this.message = message;
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}