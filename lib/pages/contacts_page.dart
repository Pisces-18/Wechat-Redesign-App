import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/pages/qr_page.dart';
import 'package:wechat_redesign_app/pages/qr_scanner_page.dart';

import '../blocs/contacts_bloc.dart';
import '../custom_widget/custom_user_image_widget.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/title_and_contact_section_custom_view.dart';
import 'chat_details_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactsBloc(),
      child: Scaffold(
        backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Contacts",
                style: TextStyle(
                    color: PRIMARY_COLOR_1,
                    fontSize: TEXT_BIG,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: " (6)",
                style: TextStyle(
                    color: DONT_RECEIVE_OTP_COLOR,
                    fontSize: TEXT_SMALL,
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QrPage())),
              child: Padding(
                  padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
                  child: Image.asset(
                    "assets/images/contact.png",
                    width: MARGIN_XLARGE,
                    height: MARGIN_XLARGE,
                  )),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: MARGIN_MEDIUM_3,
            right: MARGIN_MEDIUM_X,
            bottom: MARGIN_MEDIUM_2,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBoxView(),
                Visibility(
                  visible: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 160),
                    child: Column(
                      children: [
                        Image.asset("assets/images/contactPlaceholder.png"),
                        const SizedBox(
                          height: MARGIN_MEDIUM_3,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "No contact or group with name ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: TEXT_REGULAR_2X,
                                    color: CONTACT_TEXT_COLOR),
                              ),
                              TextSpan(
                                text: '"Aung Naing"',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: TEXT_REGULAR_2X,
                                    color: PRIMARY_COLOR_1),
                              ),
                              TextSpan(
                                text: " exits",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: TEXT_REGULAR_2X,
                                    color: CONTACT_TEXT_COLOR),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    // GroupSectionView(),
                    // const SizedBox(
                    //   height: TEXT_REGULAR_2LX,
                    // ),
                    Consumer<ContactsBloc>(
                        builder: (context, bloc, child) =>
                            TitleAndContactSectionCustomView(
                              title: "",
                              contactList: bloc.contactList ?? [],
                              onTapContact: (uid) {
                                bloc.onTapContact(uid).then((value){
                                  if(bloc.sender !=null && bloc.receiver !=null){
                                    _navigateToChatDetailsPage(context,bloc.sender!,bloc.receiver!);
                                  }
                                }).catchError((error){
                                  debugPrint("On Tap Chat Error===>$error");
                                });

                              },
                            )),
                    const SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    // ListView.separated(
                    //     shrinkWrap: true,
                    //     physics: const ScrollPhysics(),
                    //     itemBuilder: (context,index){
                    //       return TitleAndContactSectionCustomView(title: "A",name: "Name",);
                    //     }, separatorBuilder: (context,index){
                    //   return const SizedBox(height: MARGIN_MEDIUM_2,);
                    //
                    // }, itemCount: 3)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToChatDetailsPage(
          BuildContext context, UserVO sender, UserVO receiver) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatDetailsPage(sender: sender,receiver: receiver,)));
}

class GroupSectionView extends StatelessWidget {
  const GroupSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Groups(5)",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR,
              color: PRIMARY_COLOR_1),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_X,
        ),
        Container(
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MARGIN_MEDIUM_X, horizontal: MARGIN_SMALL),
                    width: CHAT_GROUP_SIZE,
                    height: CHAT_GROUP_SIZE,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/group.png"),
                          Text(
                            "Group Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: TEXT_REGULAR,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}

class SearchBoxView extends StatelessWidget {
  const SearchBoxView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
      width: MediaQuery.of(context).size.width / 1.09,
      decoration: BoxDecoration(
        color: SEARCH_BOX_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_MEDIUM,
        ),
      ),
      child: TextField(
        style: const TextStyle(
          color: PRIMARY_COLOR_4,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Image.asset(
              "assets/images/search_icon.png",
              width: SEARCH_ICON_SIZE,
              height: SEARCH_ICON_SIZE,
            ),
            filled: true,
            hintText: "Search",
            hintStyle: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.displaySmall,
              color: PRIMARY_COLOR_4,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
