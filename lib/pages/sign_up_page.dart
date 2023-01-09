import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/blocs/sign_up_bloc.dart';
import 'package:wechat_redesign_app/resources/strings.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../resources/colors.dart';
import '../resources/datas.dart';
import '../resources/datas.dart';
import '../resources/datas.dart';
import '../resources/datas.dart';
import '../resources/datas.dart';
import '../resources/dimens.dart';
import '../viewitems/custom_primary_button_view.dart';
import '../viewitems/custom_welcome_and_hi_view.dart';
import '../viewitems/date_of_birth_section_view.dart';
import '../viewitems/gender_section_view.dart';
import '../viewitems/label_and_textfield_view.dart';
import 'main_page.dart';
import 'moment_page.dart';

class SignUpPage extends StatelessWidget {
  final String phoneNumber;
  const SignUpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day="Day";
    String month="Month";
    String year="Year";
    bool isChecked=false;
    return ChangeNotifierProvider(
      create: (context) => SignUpBloc(),
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
          child: Selector<SignUpBloc,bool>(
            selector: (context,bloc)=>bloc.isLoading,
            builder: (context,isLoading,child)=> SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomWelcomeAndHiView(
                        label1: LBL_HI,
                        label2: LBL_VERIFY_PAGE_TEXT_1,
                        isHasImage: false,
                      ),
                      // const SizedBox(
                      //   height: MARGIN_MEDIUM_3,
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(right: MARGIN_XXXLARGE),
                        child: Consumer<SignUpBloc>(
                            builder: (context, bloc, child) => LabelAndTextFieldView(
                                  label: LBL_NAME,
                                  isName: true,
                                  onChanged: (name)=>bloc.onUserNameChanged(name),
                                ),),
                      ),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                      Consumer<SignUpBloc>(
                        builder: (context, bloc, child) => LabelAndTextFieldView(
                          label: LBL_EMAIL,
                          isEmail: true,
                          onChanged: (email)=>bloc.onEmailChanged(email),
                        ),),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                       DateOfBirthSectionView(dayValue: (value) {
                         day=value;
                       }, monthValue: (value) {
                         month=value;
                       }, yearValue: (value) {
                         year=value;
                       },),
                      const SizedBox(
                        height: MARGIN_XLLARGE,
                      ),
                      const  GenderSectionView(),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                      Consumer<SignUpBloc>(
                        builder: (context,bloc,child)=> LabelAndTextFieldView(
                          label: LBL_SIGN_UP_PASSWORD,
                          onChanged: (password)=>bloc.onPasswordChanged(password),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_XXLARGEL,
                      ),
                      TermAndServiceCheckView(
                        isChecked: (check) {
                          isChecked=check;
                        },
                      ),
                      const SizedBox(
                        height: MARGIN_XXXXLARGE,
                      ),
                      Consumer<SignUpBloc>(
                        builder: (context,bloc,child)=>GestureDetector(
                          onTap: () {
                            debugPrint("Phone Number===>$phoneNumber");
                           if(day !="Day" && month !="Month" && year !="Year" && isChecked != false ){
                             bloc.onTapSignUp(phoneNumber).then((value)async{
                               bloc.onTapLogin(phoneNumber).then((value) => _navigateToMainPage(context));
                             }).catchError((error){
                               debugPrint("Register Error===>$error");
                             });
                           }
                          },
                          child: Center(
                            child: const CustomPrimaryButtonView(
                              label: LBL_SIGN_UP,
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
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: SizedBox(
          width: MARGIN_XXLARGE,
          height: MARGIN_XXLARGE,
          child: LoadingIndicator(
            indicatorType: Indicator.audioEqualizer,
            colors: [Colors.white],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
class TermAndServiceCheckView extends StatefulWidget {
  final Function(bool) isChecked;
  const TermAndServiceCheckView({
    Key? key,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<TermAndServiceCheckView> createState() =>
      _TermAndServiceCheckViewState();
}

class _TermAndServiceCheckViewState extends State<TermAndServiceCheckView> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: MaterialStateBorderSide.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const BorderSide(color: PRIMARY_COLOR_1);
              }
              return const BorderSide(color: PRIMARY_COLOR_1);
            },
          ),
          value: isCheck,
          onChanged: (value) {
            setState(() {
              isCheck = value!;
              widget.isChecked(isCheck);
            });
          },
          activeColor: PRIMARY_COLOR_1,
          checkColor: Colors.white,
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: LBL_SIGN_UP_TEXT_1,
            style: TextStyle(
                color: AGREE_TEXT_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: TEXT_SMALL),
          ),
          TextSpan(
            text: LBL_SIGN_UP_TEXT_2,
            style: TextStyle(
                color: HOME_PAGE_TEXT_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: TEXT_SMALL),
          ),
        ]))
      ],
    );
  }
}





class GenderSelectRadioButtonView extends StatefulWidget {
  final String label;
  const GenderSelectRadioButtonView({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  State<GenderSelectRadioButtonView> createState() =>
      _GenderSelectRadioButtonViewState();
}

class _GenderSelectRadioButtonViewState
    extends State<GenderSelectRadioButtonView> {
  late String radioValue = "Male";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.deepPurple),
          child: Radio<String>(
            value: widget.label,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value!;
                // widget.radioValue=value;
                debugPrint("Checked Radio===>$value");
              });
            },
            activeColor: Colors.deepPurple,
          ),
        ),
        Text(
          widget.label,
          style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}



class LabelTextView extends StatelessWidget {
  final String label;
  const LabelTextView({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: TEXT_FIELD_LABEL_COLOR,
          fontWeight: FontWeight.w400,
          fontSize: TEXT_SMALL),
    );
  }
}

class DropDownButtonView extends StatefulWidget {
  final List<String> dropDownData;
  final Function(String) onChanged;
  final String dropDownValue;
  const DropDownButtonView(
      {Key? key,
      required this.dropDownData,
      required this.onChanged,
      required this.dropDownValue})
      : super(key: key);

  @override
  State<DropDownButtonView> createState() => _DropDownButtonViewState();
}

class _DropDownButtonViewState extends State<DropDownButtonView> {
  //String dropDownValue=dayList[0];
  @override
  Widget build(BuildContext context) {
    // String dropDownValue=widget.dropDownData[0];
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            elevation: 0,
            dropdownColor: Colors.deepPurple,
            value: widget.dropDownValue,
            style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.bodySmall,
                color: HOME_PAGE_TEXT_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400),
            onChanged: (String? newValue) {
              setState(() {
                widget.onChanged(newValue!);
              });
            },
            items: widget.dropDownData
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
          ),
        ),
      ),
    );
  }
}
