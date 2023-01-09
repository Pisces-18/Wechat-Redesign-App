import 'package:flutter/material.dart';

import '../pages/sign_up_page.dart';
import '../resources/colors.dart';
import '../resources/datas.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class GenderSectionView extends StatefulWidget {
  const GenderSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<GenderSectionView> createState() => _GenderSectionViewState();
}
class _GenderSectionViewState extends State<GenderSectionView> {
  String radioValue = "Male";
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LabelTextView(
            label: LBL_GENDER,
          ),
          const SizedBox(height: MARGIN_MEDIUM,),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: HOME_PAGE_TEXT_COLOR),
                      child: Radio<String>(
                        value: genderList[0],
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = value!;
                            // widget.radioValue=value;
                            debugPrint("Checked Radio===>$value");
                          });
                        },
                        activeColor: HOME_PAGE_TEXT_COLOR,
                      ),
                    ),
                    Text(
                      genderList[0],
                      style: TextStyle(
                          color: HOME_PAGE_TEXT_COLOR,
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: HOME_PAGE_TEXT_COLOR),
                      child: Radio<String>(
                        value: genderList[1],
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = value!;
                            // widget.radioValue=value;
                            debugPrint("Checked Radio===>$value");
                          });
                        },
                        activeColor: HOME_PAGE_TEXT_COLOR,
                      ),
                    ),
                    Text(
                      genderList[1],
                      style: TextStyle(
                          color: HOME_PAGE_TEXT_COLOR,
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: HOME_PAGE_TEXT_COLOR),
                      child: Radio<String>(
                        value: genderList[2],
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = value!;
                            // widget.radioValue=value;
                            debugPrint("Checked Radio===>$value");
                          });
                        },
                        activeColor: HOME_PAGE_TEXT_COLOR,
                      ),
                    ),
                    Text(
                      genderList[2],
                      style: TextStyle(
                          color: HOME_PAGE_TEXT_COLOR,
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // GenderSelectRadioButtonView(label: genderList[2]),
              ]),
        ]);
  }
}