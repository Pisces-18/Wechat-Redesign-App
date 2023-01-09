import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../blocs/me_bloc.dart';
import '../blocs/moment_bloc.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/custom_primary_button_view.dart';
import '../viewitems/date_of_birth_section_view.dart';
import '../viewitems/gender_section_view.dart';
import '../viewitems/label_and_textfield_view.dart';
import '../viewitems/moment_item_view.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => MeBloc(),
      child: Selector<MeBloc,UserVO?>(
        selector: (context,bloc)=>bloc.loggedInUser,
        builder : (context,user,child)=>Scaffold(
          backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              "Me",
              style: TextStyle(
                  color: PRIMARY_COLOR_1,
                  fontSize: TEXT_X_BIG,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UserInfoDialog();
                      });
                },
                child: Padding(
                    padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
                    child: Image.asset(
                      "assets/images/me_edit.png",
                      width: MARGIN_XLARGE,
                      height: MARGIN_XLARGE,
                    )),
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(MARGIN_MEDIUM_2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserInfoSectionView(user: user,),
                  const SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bookmarked Moments",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                          fontSize: TEXT_REGULAR_3X,
                          color: PRIMARY_COLOR_1,
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      // Container(
                      //   child: Consumer<MomentBloc>(
                      //     builder: (context, bloc, child) => ListView.separated(
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: MARGIN_LARGE, horizontal: MARGIN_LARGE),
                      //         itemBuilder: (context, index) {
                      //           return MomentItemView(
                      //             moment: bloc.moments?[index],
                      //             onTapDelete: (momentId) {
                      //               bloc.onTapDeletePost(momentId);
                      //             },
                      //             onTapEdit: (momentId) {
                      //               debugPrint("Moment Id===>$momentId");
                      //               Future.delayed(const Duration(milliseconds: 1000))
                      //                   .then((value) {
                      //                 //_navigateToEditMomentPage(context, momentId);
                      //               });
                      //             },
                      //           );
                      //         },
                      //         separatorBuilder: (context, index) {
                      //           return const SizedBox(
                      //             height: MARGIN_XLARGE,
                      //           );
                      //         },
                      //         itemCount: bloc.moments?.length ?? 0),
                      //   ),
                      // )

                      QrImage(
                        data: user?.id ?? "",
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoSectionView extends StatelessWidget {
  const UserInfoSectionView({
    Key? key, required this.user,
  }) : super(key: key);
  final UserVO? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_CARD_MEDIUM_2),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        color: PRIMARY_COLOR_1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/profile.png"),
              ),
              Positioned(
                top: 85,
                left: 70,
                child: Image.asset("assets/images/QR.png"),
              ),
              Positioned(
                top: 110,
                child: Image.asset("assets/images/uploadProfile.png"),
              ),
            ],
          ),
          const SizedBox(
            width: MARGIN_XLARGE,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.userName ?? "",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: TEXT_REGULAR_3X),
              ),
              const SizedBox(
                height: 11,
              ),
              UserDataView(
                icon: "assets/images/phone.png",
                text: user?.phoneNumber ?? "",
              ),
              const SizedBox(
                height: 11,
              ),
              UserDataView(
                icon: "assets/images/Date_range.png",
                text: "1988-06-05",
              ),
              const SizedBox(
                height: 11,
              ),
              UserDataView(
                icon: "assets/images/gender.png",
                text: "Male",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserDataView extends StatelessWidget {
  const UserDataView({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon),
        const SizedBox(
          width: 14,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ],
    );
  }
}

class UserInfoDialog extends StatelessWidget {
  const UserInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day = "Day";
    String month = "Month";
    String year = "Year";
    bool isChecked = false;
    return AlertDialog(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              left: MARGIN_CARD_MEDIUM_2,
              right: MARGIN_CARD_MEDIUM_2,
              bottom: MARGIN_CARD_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelAndTextFieldView(
                label: LBL_NAME,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              LabelAndTextFieldView(
                label: LBL_PHONE,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              DateOfBirthSectionView(
                dayValue: (value) {
                  day = value;
                },
                monthValue: (value) {
                  month = value;
                },
                yearValue: (value) {
                  year = value;
                },
                isDialog: true,
              ),
              const SizedBox(
                height: MARGIN_XLLARGE,
              ),
              const GenderSectionView(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_XLARGE),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:()=>Navigator.pop(context),
                      child: CustomPrimaryButtonView(
                        label: LBL_CANCEL,
                        themeColor: Colors.white,
                        isGetOtp: true,
                        isSignUp: true,
                      ),
                    ),
                    const SizedBox(
                      width: MARGIN_MEDIUM_3,
                    ),
                    CustomPrimaryButtonView(
                      label: LBL_SAVE,
                      themeColor: PRIMARY_COLOR_1,
                      isGetOtp: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

