import 'package:flutter/material.dart';

import '../pages/sign_up_page.dart';
import '../resources/datas.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class DateOfBirthSectionView extends StatefulWidget {
  final Function(String) dayValue;
  final Function(String) monthValue;
  final Function(String) yearValue;
  final bool isDialog;

  const DateOfBirthSectionView({
    Key? key, required this.dayValue, required this.monthValue, required this.yearValue,this.isDialog=false
  }) : super(key: key);

  @override
  State<DateOfBirthSectionView> createState() => _DateOfBirthSectionViewState();
}

class _DateOfBirthSectionViewState extends State<DateOfBirthSectionView> {
  late String dayDropDownValue = dayList[0];
  late String monthDropDownValue = monthList[0];
  late String yearDropDownValue = yearList[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextView(
          label: LBL_DATE_OF_BIRTH,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            DropDownButtonView(
              dropDownData: dayList,
              onChanged: (value) {
                setState(() {
                  dayDropDownValue = value;
                  widget.dayValue(value);
                });
              },
              dropDownValue: dayDropDownValue,
            ),
             SizedBox(
              width: (widget.isDialog)? MARGIN_SMALL: MARGIN_MEDIUM_2,
            ),
            DropDownButtonView(
              dropDownData: monthList,
              onChanged: (value) {
                setState(() {
                  monthDropDownValue = value;
                  widget.monthValue(value);
                });
              },
              dropDownValue: monthDropDownValue,
            ),
             SizedBox(
              width: (widget.isDialog)? MARGIN_SMALL: MARGIN_MEDIUM_2,
             ),
            DropDownButtonView(
              dropDownData: yearList,
              onChanged: (value) {
                setState(() {
                  yearDropDownValue = value;
                  widget.yearValue(value);
                });
              },
              dropDownValue: yearDropDownValue,
            ),
          ],
        )
      ],
    );
  }
}