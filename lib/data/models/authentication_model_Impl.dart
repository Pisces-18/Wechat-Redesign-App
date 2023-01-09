import 'package:wechat_redesign_app/data/models/authentication_model.dart';
import 'package:wechat_redesign_app/data/vos/user_vo.dart';
import 'package:wechat_redesign_app/network/dataagents/wechat_data_agent.dart';

import '../../network/dataagents/cloud_firestore_data_agent_impl.dart';
import '../../network/dataagents/real_time_database_data_agent_impl.dart';


class AuthenticationModelImpl extends AuthenticationModel{
  static final AuthenticationModelImpl _singleton = AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  ///Data Agent
 WechatDataAgent mDataAgent=CloudFireStoreDataAgentImpl();
 //  WechatDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();


  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Future<void> login(String email,String password) {
    return mDataAgent.login(email,password);
  }

  @override
  Future<void> register(String phoneNumber,String email, String userName, String password) {
    return craftUserVO(phoneNumber,email, userName, password)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(String phoneNumber,String email, String userName, String password){
    var newUser=UserVO(
      id: "",
      userName: userName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
    return Future.value(newUser);
  }

  @override
  Future verifyPhoneNumber(String phoneNumber) {
    return mDataAgent.verifyPhoneNumber(phoneNumber);
  }
}