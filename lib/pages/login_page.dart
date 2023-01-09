import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/pages/moment_page.dart';
import 'package:wechat_redesign_app/pages/sign_up_page.dart';

import '../blocs/login_bloc.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/custom_primary_button_view.dart';
import '../viewitems/custom_welcome_and_hi_view.dart';
import '../viewitems/label_and_textfield_view.dart';
import 'main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: PRIMARY_COLOR_1,
              )),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
          child: Selector<LoginBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWelcomeAndHiView(
                        label1: LBL_WECOME,
                        label2: LBL_LOGIN_TEXT_1,
                        image: "assets/images/login_image.png",
                      ),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: MARGIN_XXLARGE),
                        child: Consumer<LoginBloc>(
                          builder: (context, bloc, child) => LabelAndTextFieldView(
                            label: LBL_EMAIL,
                            onChanged: (email)=>bloc.onEmailChanged(email),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_XLLARGE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => LabelAndTextFieldView(
                          label: LBL_PASSWORD,
                          onChanged: (password)=>bloc.onPasswordChanged(password),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_MEDIUM_3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            LBL_FORGOT_PASSWORD,
                            style: TextStyle(
                                color: HOME_PAGE_TEXT_COLOR,
                                fontSize: TEXT_REGULAR,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: MARGIN_XXLLARGE,
                      ),
                      Center(
                        child: Consumer<LoginBloc>(
                          builder: (context, bloc, child) => GestureDetector(
                            onTap: () {
                              bloc.onTapLogin().then((value){
                                _navigateToMainPage(context);
                              }).catchError((error){
                                debugPrint("Login Error===>$error");
                              });
                              //_navigateToMainPage(context);
                            },
                            child: const CustomPrimaryButtonView(
                              label: LBL_LOGIN,
                              themeColor: PRIMARY_COLOR_1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isLoading,
                    child: Container(
                      color: Colors.black12,
                      child: const Center(
                        child: LoadingView(),
                      ),
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMainPage(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => MainPage()));
}
