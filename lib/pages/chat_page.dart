import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/pages/chat_details_page.dart';
import 'package:wechat_redesign_app/resources/colors.dart';

import '../blocs/chat_bloc.dart';
import '../custom_widget/custom_user_image_widget.dart';
import '../data/vos/user_vo.dart';
import '../resources/dimens.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ChatBloc(),
      child: Scaffold(
        backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Chats",
            style: TextStyle(
                color: PRIMARY_COLOR_1,
                fontSize: TEXT_X_BIG,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
                  child: Image.asset(
                    "assets/images/search.png",
                    width: MARGIN_XLARGE,
                    height: MARGIN_XLARGE,
                  )),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                ActiveNowTextView(),
                const SizedBox(
                  height: MARGIN_CARD_MEDIUM_2,
                ),
                Selector<ChatBloc,List<UserVO>?>(
                    selector: (context,bloc)=>bloc.contactList,
                    builder : (context,users,child)=> ActiveNowPeopleListView(userList: users?? [],)),
                Selector<ChatBloc,List<UserVO>?>(
                  selector: (context,bloc)=>bloc.contactList,
                  builder : (context,users,child)=> ChartListView(
                    onTapChat: (uid) {
                     setState(() {
                       debugPrint("User Id===>$uid");
                       ChatBloc bloc= Provider.of<ChatBloc>(context, listen: false);
                       bloc.onTapChat(uid).then((value)async{
                         if(bloc.sender !=null && bloc.receiver !=null){
                           _navigateToChatDetailsPage(context,bloc.sender!,bloc.receiver!);
                         }
                       }).catchError((error){
                         debugPrint("On Tap Chat Error===>$error");
                       });
                     });
                     }, userList: users?? [],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToChatDetailsPage(BuildContext context,UserVO sender, UserVO receiver) {
    return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatDetailsPage(sender: sender,receiver: receiver,)));
  }
}

class ChartListView extends StatelessWidget {
  final Function(String) onTapChat;
  final List<UserVO> userList;
  const ChartListView({
    Key? key,
    required this.onTapChat, required this.userList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: userList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () => onTapChat(userList[index].id ?? ""), child: ChartListItemView(user: userList[index],));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: MARGIN_MEDIUM_2,
        );
      },
    );
  }
}

class ChartListItemView extends StatelessWidget {
  const ChartListItemView({
    Key? key, required this.user,
  }) : super(key: key);
final UserVO user;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomUserImageWidget(profilePicture: user.profilePicture ?? "",),
              const SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName ?? "",
                    style: TextStyle(
                        color: PRIMARY_COLOR_1,
                        fontWeight: FontWeight.w400,
                        fontSize: TEXT_REGULAR_2X),
                  ),
                  const SizedBox(
                    height: MARGIN_SMALL,
                  ),
                  Text(
                    "text",
                    style: TextStyle(
                        color: DONT_RECEIVE_OTP_COLOR,
                        fontWeight: FontWeight.w400,
                        fontSize: TEXT_REGULAR),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "text",
                    style: TextStyle(
                        color: PRIMARY_COLOR_1,
                        fontWeight: FontWeight.w600,
                        fontSize: TEXT_SMALL),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Image.asset("assets/images/mark.png")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveNowPeopleListView extends StatelessWidget {
  const ActiveNowPeopleListView({
    Key? key, required this.userList,
  }) : super(key: key);
  final List<UserVO> userList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
      height: 90,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ActiveNowPeopleView(user: userList[index],);
        },
      ),
    );
  }
}

class ActiveNowPeopleView extends StatelessWidget {
  const ActiveNowPeopleView({
    Key? key, this.user,
  }) : super(key: key);
  final UserVO? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: 60,
      child: Column(
        children: [
          CustomUserImageWidget(profilePicture: '',),
          PeopleNameView(name: user?.userName?? "",),
        ],
      ),
    );
  }
}

class PeopleNameView extends StatelessWidget {
  const PeopleNameView({
    Key? key, required this.name,
  }) : super(key: key);
final String name;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Text(
        name,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TEXT_EXTRA_SMALL,
            color: PRIMARY_COLOR_1,
            height: 2.0),
      ),
    );
  }
}

class ActiveNowTextView extends StatelessWidget {
  const ActiveNowTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      child: Text(
        "Active Now",
        style: TextStyle(
            color: PRIMARY_COLOR_4,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ChatTitleView extends StatelessWidget {
  const ChatTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: MARGIN_XLARGE),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_CARD_MEDIUM_2),
          //height: 80,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text(
                "Chats",
                style: TextStyle(
                    color: PRIMARY_COLOR_1,
                    fontSize: TEXT_X_BIG,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Image.asset("assets/images/search.png"),
            ],
          ),
        ),
      ),
    );
  }
}
