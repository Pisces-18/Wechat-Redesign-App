import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class CustomWelcomeAndHiView extends StatelessWidget {
  final String label1;
  final String label2;
  final bool isHasImage;
  final String image;
  const CustomWelcomeAndHiView({
    Key? key, required this.label1, required this.label2,this.isHasImage=true,this.image="assets/images/sign_up_image.png"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label1,
          style: GoogleFonts.aBeeZee(
            fontSize: TEXT_HEADING_3X,
            fontWeight: FontWeight.w700,
            color: PRIMARY_COLOR_1,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM,),
        Text(
          label2,
          style: GoogleFonts.aBeeZee(
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w400,
            color: PRIMARY_COLOR_2,
          ),
        ),
        const SizedBox(height: MARGIN_XXLARGE,),
        Visibility(
            visible: isHasImage,
            child: Center(child: Image.asset(image,fit: BoxFit.cover,))),
      ],
    );
  }
}