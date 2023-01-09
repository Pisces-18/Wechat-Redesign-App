import 'package:flutter/material.dart';

import '../custom_widget/custom_user_image_widget.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class TitleAndContactSectionCustomView extends StatefulWidget {
  const TitleAndContactSectionCustomView({
    Key? key,
    required this.title,
    required this.contactList,
    this.isGroup=false, required this.onTapContact,
  }) : super(key: key);
  final String title;
  final bool isGroup;
  final List<UserVO> contactList;
  final Function(String) onTapContact;

  @override
  State<TitleAndContactSectionCustomView> createState() => _TitleAndContactSectionCustomViewState();
}

class _TitleAndContactSectionCustomViewState extends State<TitleAndContactSectionCustomView> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_X),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X,
                color: PRIMARY_COLOR_1),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_3,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()=>widget.onTapContact(widget.contactList[index].id ?? ""),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        CustomUserImageWidget(profilePicture: widget.contactList[index].profilePicture?? "",),
                        const SizedBox(
                          width: MARGIN_MEDIUM_2,
                        ),
                        Text(
                          widget.contactList[index].userName?? "",
                          style: TextStyle(
                            color: PRIMARY_COLOR_1,
                            fontSize: TEXT_REGULAR_2X,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Visibility(
                          visible:widget.isGroup,
                          child: Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const BorderSide(color: PRIMARY_COLOR_1);
                                }
                                return const BorderSide(color: PRIMARY_COLOR_1);
                              },
                            ),
                            value: isCheck,
                            shape: CircleBorder(),
                            onChanged: (value) {
                              setState(() {
                                isCheck = value!;
                               // widget.isChecked(isCheck);
                              });
                            },
                            activeColor: PRIMARY_COLOR_1,
                            checkColor: CHECK_BOX_CHECK_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: MARGIN_MEDIUM,
                );
              },
              itemCount: widget.contactList.length)
        ],
      ),
    );
  }
}
