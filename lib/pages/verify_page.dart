import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/blocs/verify_bloc.dart';
import 'package:wechat_redesign_app/pages/sign_up_page.dart';
import 'package:wechat_redesign_app/resources/strings.dart';
import 'package:wechat_redesign_app/viewitems/custom_welcome_and_hi_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/custom_primary_button_view.dart';
import '../viewitems/label_and_textfield_view.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>VerifyBloc(),
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
              ),),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWelcomeAndHiView(
                    label1: LBL_HI,
                    label2: LBL_VERIFY_PAGE_TEXT_1,
                    image: "assets/images/sign_up_image.png"),
                const SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                TextFieldAndGetOtpView(),
                const SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                Consumer<VerifyBloc>(
                  builder:(context,bloc,child) =>OTPCodeSectionView(onTapVerify: (otp) {
                    if(otp == "1234"){
                      _navigateToSignUpPage(context, "+959758347723");
                    }
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<dynamic> _navigateToSignUpPage(BuildContext context,String phoneNumber) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpPage(phoneNumber: phoneNumber,)));
}

class OTPCodeSectionView extends StatelessWidget {
  final Function(String) onTapVerify;
  const OTPCodeSectionView({
    Key? key, required this.onTapVerify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text1;
    String? text2;
    String? text3;
    String? text4;
    String _otp="";
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OTPTextView(
                onChanged: (text) {
                  text1 = text;
                },
              ),
              const SizedBox(
                width: MARGIN_CARD_MEDIUM_2,
              ),
              OTPTextView(
                onChanged: (text) {
                  text2 = text;
                },
              ),
              const SizedBox(
                width: MARGIN_CARD_MEDIUM_2,
              ),
              OTPTextView(
                onChanged: (text) {
                  text3 = text;
                },
              ),
              const SizedBox(
                width: MARGIN_CARD_MEDIUM_2,
              ),
              OTPTextView(
                onChanged: (text) {
                  text4 = text;
                },
              ),
            ],
          ),
          const SizedBox(
            height: MARGIN_XLARGE,
          ),
          ResendCodeTextView(),
          const SizedBox(
            height: MARGIN_XXLARGE,
          ),
          GestureDetector(
              onTap: () {
                _otp = "${text1}${text2}${text3}${text4}";
                debugPrint("OTP Code====>$_otp");
                // if (_otp == "1234") {
                //   onTapVerify(_otp);
                // }
                onTapVerify(_otp);
  },
              child: CustomPrimaryButtonView(
                label: LBL_VERIFY,
                themeColor: PRIMARY_COLOR_1,
              ))
        ],
      ),
    );
  }


}

class ResendCodeTextView extends StatelessWidget {
  const ResendCodeTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: LBL_DONT_RECEIVE_OTP,
          style: TextStyle(color: DONT_RECEIVE_OTP_COLOR, fontSize: TEXT_REGULAR,fontWeight: FontWeight.w400),
        ),
        TextSpan(
            text: LBL_RESEND_CODE,
            style: TextStyle(
                color: PRIMARY_COLOR_1,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400))
      ]),
    );
  }
}

class OTPTextView extends StatefulWidget {
  final Function(String) onChanged;
  const OTPTextView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<OTPTextView> createState() => _OTPTextViewState();
}

class _OTPTextViewState extends State<OTPTextView> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
        width: 50,
        child: Center(
          child: TextFormField(
            controller: _textController,
            onChanged: (text) {
              setState(() {
                widget.onChanged(text);
                FocusScope.of(context).nextFocus();
              });
            },
            style: TextStyle(
                color: PRIMARY_COLOR_1,
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_3X),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            cursorHeight: MARGIN_LARGE,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldAndGetOtpView extends StatelessWidget {
  const TextFieldAndGetOtpView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<VerifyBloc>(
          builder:(context,bloc,child)=>Container(
              width: MediaQuery.of(context).size.width / 1.7,
              child: LabelAndTextFieldView(
                label: LBL_PHONE_NUMBER,
                onChanged: (phoneNumber)=>bloc.onPhoneNumberChange(phoneNumber),
              ),),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: MARGIN_MEDIUM_3),
          child: Consumer<VerifyBloc>(
            builder:(context,bloc,child)=>GestureDetector(
              onTap: (){
                bloc.getOtp();
              },
              child: CustomPrimaryButtonView(
                label: LBL_GET_OTP,
                themeColor: PRIMARY_COLOR_1,
                isGetOtp: true,
              ),
            ),
          ),
        )
      ],
    );
  }
}
