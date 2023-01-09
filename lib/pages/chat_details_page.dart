import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../blocs/chat_details_bloc.dart';
import '../custom_widget/custom_user_image_widget.dart';
import '../data/vos/message_vo.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import 'package:intl/intl.dart';


// List<ChatMessageModel> messages = [
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 3,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Yeah", date: DateTime.now().subtract(Duration(days: 3,minutes: 4)),isSendByMe: true),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 3,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 3,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 4,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 4,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 4,minutes: 3)),isSendByMe: false),
//   ChatMessageModel(messageContent: "Hello, Will", date: DateTime.now().subtract(Duration(days: 4,minutes: 3)),isSendByMe: false),
// ];
class ChatDetailsPage extends StatelessWidget {
  final UserVO sender;
  final UserVO receiver;
  const ChatDetailsPage({Key? key, required this.sender, required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Receiver====>${receiver.userName}");
    return ChangeNotifierProvider(
      create: (context)=>ChatDetailsBloc(sender, receiver),
      child: Scaffold(
        backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
        appBar: AppBar(
          backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
          automaticallyImplyLeading: false,
          title: Selector<ChatDetailsBloc,UserVO?>(
            selector: (context,bloc)=>bloc.receiverUser,
            builder : (context,user,child)=> Row(
              children: [
                 CustomUserImageWidget(profilePicture: user?.profilePicture ?? "",),
                const SizedBox(width: 10,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.userName ?? "",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w700),),
                    Text("Online",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_SMALL,fontWeight: FontWeight.w500),)

                  ],
                ),
              ],
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: PRIMARY_COLOR_1,
            ),),
          actions: [
            Padding(
                padding: EdgeInsets.only(top: MARGIN_MEDIUM),
                child: Icon(Icons.more_vert,color: PRIMARY_COLOR_1,))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Expanded(
                child: Consumer<ChatDetailsBloc>(
                  builder:(context,bloc,child) => Container(
                    child: ListView.builder(
                      itemCount: bloc.messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Container(
                          padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                          child: Align(
                              alignment: ((bloc.messages[index].useId)== receiver?.id) ?Alignment.topLeft:Alignment.topRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (bloc.messages[index].useId  == receiver?.id ?RECEIVER_CHAT_COLOR:HOME_PAGE_SIGN_UP_BUTTON_COLLOR),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(bloc.messages[index].message?? "",style: TextStyle(fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w400,
                                            color: (bloc.messages[index].useId != receiver?.id)? Colors.white:HOME_PAGE_SIGN_UP_BUTTON_COLLOR),))),
                        );
                      },
                    ),
                  ),

                  //     GroupedListView<MessageVO,DateTime>(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.all(MARGIN_MEDIUM),
                  //   useStickyGroupSeparators: true,
                  //   floatingHeader: true,
                  //   reverse: true,
                  //   order: GroupedListOrder.DESC,
                  //   elements: bloc.messages ?? [],
                  //   groupBy: (message) =>DateTime(DateTime.now().day),
                  //   groupHeaderBuilder: (message)=>Center(
                  //     child: Text(DateFormat.yMMMd().format(DateTime.now())),
                  //   ),
                  //   itemBuilder: (context,MessageVO message)=>Align(
                  //     alignment: (message.useId != receiverId) ? Alignment.centerRight:Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //              Visibility(
                  //                  visible:!(message.useId != receiverId),
                  //                  child: CustomUserImageWidget(imageSize: 40, profilePicture: '',),),
                  //             const SizedBox(width: MARGIN_SMALL,),
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  //                 color:(message.useId != receiverId)? HOME_PAGE_SIGN_UP_BUTTON_COLLOR:RECEIVER_CHAT_COLOR,
                  //               ),
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM,vertical: MARGIN_SMALL),
                  //                 child: Column(
                  //                   children: [
                  //                     Text(message.message?? "",style: TextStyle(fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w400,
                  //                     color: (message.useId != receiverId)? Colors.white:HOME_PAGE_SIGN_UP_BUTTON_COLLOR),),
                  //                   ],
                  //                 ),
                  //
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         //Image.asset("assets/images/Logo.png"),
                  //
                  //       ],
                  //     ),
                  //   ),
                  //
                  // ),
                ),
              ),

            //Center(child: Text("Today",style: TextStyle(color: DONT_RECEIVE_OTP_COLOR,fontWeight: FontWeight.w400,fontSize: TEXT_REGULAR),),),


            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Consumer<ChatDetailsBloc>(
                          builder: (context,bloc,child)=> Container(
                            width: MediaQuery.of(context).size.width/1.6,
                            child: TextField(
                              onChanged: (message)=>bloc.onMessageChanged(message),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
                                hintText: "Type a message...",
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Consumer<ChatDetailsBloc>(
                          builder: (context,bloc,child)=> GestureDetector(
                              onTap: ()=>bloc.onTapSendMessage(),
                              child: Image.asset("assets/images/send.png")),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 26,vertical: 20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 249, 249, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(194, 194, 194, 0.25),
                           // spreadRadius: 10,
                          ),
                        ]
                      ),
                      child: Row(
                        children: [
                          ChatItemView(image: "assets/images/gallery1.png",onTapImage: (){},),
                          const SizedBox(width: 30,),
                          ChatItemView(image: "assets/images/camera.png",onTapImage: (){},),
                          const SizedBox(width: 30,),
                          ChatItemView(image: "assets/images/gif.png",onTapImage: (){},),
                          const SizedBox(width: 30,),
                          ChatItemView(image: "assets/images/location.png",onTapImage: (){},),
                          const SizedBox(width: 30,),
                          ChatItemView(image: "assets/images/record.png",onTapImage: (){},),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}

class ChatItemView extends StatelessWidget {
  const ChatItemView({
    Key? key, required this.image, required this.onTapImage,
  }) : super(key: key);
  final String image;
  final Function onTapImage;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Color.fromRGBO(220, 220, 220, 1),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_X,vertical: MARGIN_MEDIUM_X),
          child: Center(child: Image.asset(image))),
    );
  }
}

class ChatDetailsTitleView extends StatelessWidget {
  const ChatDetailsTitleView({
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
         // height: 80,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: PRIMARY_COLOR_1,
                ),),
             const SizedBox(width: MARGIN_CARD_MEDIUM_2,),
              CustomUserImageWidget(profilePicture: '',),
              const SizedBox(width: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w700),),
                  Text("Online",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_SMALL,fontWeight: FontWeight.w500),)

                ],
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
