import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/pages/moment_page.dart';
import 'package:wechat_redesign_app/pages/sign_up_page.dart';
import 'package:wechat_redesign_app/viewitems/custom_primary_button_view.dart';

import '../blocs/create_moment_bloc.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/moment_item_view.dart';

class CreateMomentPage extends StatelessWidget {
  final int? momentId;
  const CreateMomentPage({Key? key, this.momentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateMomentBloc(momentId: momentId),
      child: Selector<CreateMomentBloc,bool>(
        selector: (context,bloc)=>bloc.isLoading,
        builder : (context,isLoading,child)=>Stack(
          children: [
            Scaffold(
              backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: MARGIN_XLARGE,
                    color: PRIMARY_COLOR_1,
                  ),
                ),
                title: const Text(
                  "New Moment",
                  style: TextStyle(
                      color: PRIMARY_COLOR_1,
                      fontSize: TEXT_HEADING_1X,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                actions: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: MARGIN_CARD_MEDIUM_2,
                          horizontal: MARGIN_MEDIUM_2),
                      child: Consumer<CreateMomentBloc>(
                        builder: (context,bloc,child)=>GestureDetector(
                            onTap: () {
                              bloc.onTapAddNewPost().then((value) {
                                Navigator.pop(context);
                              });
                            },
                            child: const CustomPrimaryButtonView(
                              label: LBL_CREATE,
                              themeColor: PRIMARY_COLOR_1,
                              isCreate: true,
                            )),
                      )),
                ],
              ),
              body: Container(
                margin: const EdgeInsets.only(top: MARGIN_XLARGE),
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ProfileImageAndNameView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      AddNewMomentTextFieldView(),
                      SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                      PostDescriptionErrorView(),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child:  const Center(
                  child: LoadingView(),
                ),
              ),),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMomentPage(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const MomentPage()));
}

class PostDescriptionErrorView extends StatelessWidget {
  const PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateMomentBloc>(
      builder: (context, bloc, child) => Visibility(
        visible: bloc.isAddNewPostError,
        child: const Text(
          "Post should not be empty",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ),
    );
  }
}

class AddNewMomentTextFieldView extends StatelessWidget {
  const AddNewMomentTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateMomentBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: 300,
        child: TextField(
          style: TextStyle(color: DONT_RECEIVE_OTP_COLOR,fontWeight: FontWeight.w400,fontSize: TEXT_REGULAR_2LX),
          maxLines: 30,
          controller: TextEditingController(text: bloc.newPostDescription),
          onChanged: (text) {
            bloc.onNewPostTextChanged(text);
          },
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "What's on your mind?"),
        ),
      ),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateMomentBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          ProfileImageView(profileImage: bloc.profilePicture ?? ""),
          const SizedBox(
            width: MARGIN_CARD_MEDIUM_2,
          ),
          Text(
            bloc.userName ?? "",
            style: const TextStyle(
                fontSize: TEXT_REGULAR_2LX,
                color: PRIMARY_COLOR_1,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
