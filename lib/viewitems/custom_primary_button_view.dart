import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/dimens.dart';
import '../resources/colors.dart';

class CustomPrimaryButtonView extends StatelessWidget {
  final String label;
  final Color themeColor;
  final bool isSignUp;
  final bool isGetOtp;
  final bool isCreate;
  const CustomPrimaryButtonView({
    Key? key,
    required this.label,
    this.themeColor = Colors.black,
    this.isSignUp = false,
    this.isGetOtp = false,
    this.isCreate=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
      width: (isGetOtp)?MediaQuery.of(context).size.width / 4.3:(isCreate)? MediaQuery.of(context).size.width/5.7:MediaQuery.of(context).size.width / 2.7,
      height: (isGetOtp)?MARGIN_XLLARGE:MARGIN_XXLARGE,
      decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          border: (isSignUp)
              ? Border.all(
                  color: PRIMARY_COLOR_1,
                )
              : null),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.lato(
            color: (isSignUp) ? PRIMARY_COLOR_1 : Colors.white,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
