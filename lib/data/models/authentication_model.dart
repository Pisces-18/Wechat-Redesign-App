import '../vos/user_vo.dart';

abstract class AuthenticationModel{
  Future verifyPhoneNumber(String phoneNumber);
  Future<void> login(String email,String password);
  Future<void> register(String phoneNumber,String email,String userName,String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future<void> logOut();
}