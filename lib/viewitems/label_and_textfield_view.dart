import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class LabelAndTextFieldView extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool isName;
  final bool isEmail;
  const LabelAndTextFieldView({
    Key? key,
    required this.label,
    required this.onChanged,
    this.isName = false, this.isEmail=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Text("label",style: TextStyle(color: Colors.black,fontSize: TEXT_REGULAR,fontWeight: FontWeight.w400,),),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        TextFormField(
          //autovalidateMode: true,

          style: TextStyle(
              color: HOME_PAGE_TEXT_COLOR,
              fontWeight: FontWeight.w400,
              fontSize: TEXT_SMALL),
          cursorHeight: 10,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: TEXT_FIELD_LABEL_COLOR,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: HOME_PAGE_TEXT_COLOR,
              ),
            ),
          ),
          onChanged: (text)=>onChanged(text),
        )
      ],
    );
  }
}
