import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign_app/pages/login_page.dart';
import 'package:wechat_redesign_app/pages/sign_up_page.dart';
import 'package:wechat_redesign_app/pages/verify_page.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/custom_primary_button_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoView(),
            SizedBox(
              height: MediaQuery.of(context).size.height /5.1,
            ),
            const AppInfoTextSectionView(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            HomePageButtonsSectionView()
          ],
        ),
      ),
    );
  }
}

class HomePageButtonsSectionView extends StatelessWidget {
  const HomePageButtonsSectionView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: (){
            _navigateToVerifyPage(context);
          },
          child: const CustomPrimaryButtonView(
            label: LBL_SIGN_UP,
            themeColor: Colors.white,
            isSignUp: true,
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        GestureDetector(
          onTap: (){

            _navigateToLoginPage(context);
          },
          child: const CustomPrimaryButtonView(
            label: LBL_LOGIN,
            themeColor: PRIMARY_COLOR_1,
          ),
        ),
      ],
    );
  }

  Future<dynamic> _navigateToVerifyPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyPage()));

  Future<dynamic> _navigateToLoginPage(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
}

class AppInfoTextSectionView extends StatelessWidget {
  const AppInfoTextSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          HOME_PAGE_TEXT_1,
          style: GoogleFonts.aBeeZee(
            fontSize: TEXT_REGULAR_2LX,
            fontWeight: FontWeight.w600,
            color: HOME_PAGE_TEXT_COLOR,
          ),
        ),
        const SizedBox(height: MARGIN_SMALLX,),
        Text(
          HOME_PAGE_TEXT_2,
          style: GoogleFonts.aBeeZee(
            fontSize: TEXT_SMALL,
            fontWeight: FontWeight.w400,
            color: HOME_PAGE_TEXT_COLOR,
          ),
        ),
      ],
    );
  }
}

class LogoView extends StatelessWidget {
  const LogoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/Logo.png",
        width: LOGO_SIZE,
        height: LOGO_SIZE,
      ),
    );
  }
}
