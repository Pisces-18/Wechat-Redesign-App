import 'package:flutter/material.dart';
import 'package:wechat_redesign_app/data/vos/moment_vo.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class MomentItemView extends StatelessWidget {
  final MomentVO? moment;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;
  const MomentItemView({Key? key, required this.onTapDelete, required this.onTapEdit, this.moment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileImageView(profileImage: moment?.profilePicture ?? "",),
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            NameAndTimeView(userName: moment?.userName ?? "",time: "15 min",),
            Spacer(),
            MoreButtonView(onTapDelete: (){
              onTapDelete(moment?.id ?? 0);
            }, onTapEdit: (){
              onTapEdit(moment?.id ?? 0);
            },),
            
          ],
        ),
        const SizedBox(
          height: MARGIN_CARD_MEDIUM_2,
        ),
        PostDescriptionView(description: moment?.description ?? ""),
        const SizedBox(height: MARGIN_CARD_MEDIUM_2,),
        Visibility(
            visible: ((moment?.postImages??"").isNotEmpty),
            child: PostImageView(postImage: moment?.postImages ?? "",),),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            Icon(Icons.favorite_border,color: Colors.grey,),
            const SizedBox(width: MARGIN_SMALL,),
            Text(moment?.reactedCount.toString() ?? "",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w500),),
            Spacer(),
            Image.asset("assets/images/comment-dots.png",color: PRIMARY_COLOR_1,),
            const SizedBox(width: MARGIN_SMALL,),
            Text(moment?.commentedCount.toString() ?? "",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_REGULAR_2X,fontWeight: FontWeight.w500),),
            const SizedBox(width: MARGIN_MEDIUM,),
            Image.asset("assets/images/save.png",color: PRIMARY_COLOR_1,),
          ],
        )
      ],
    );
  }
}

class PostImageView extends StatelessWidget {
  final String postImage;
  const PostImageView({
    Key? key,
    required this.postImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        placeholder: const NetworkImage(''),
        image: NetworkImage(postImage),
        fit: BoxFit.cover,
      ),
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;
  const PostDescriptionView({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(fontSize: TEXT_REGULAR_2X, color: PRIMARY_COLOR_1),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  MoreButtonView({
    Key? key, required this.onTapDelete, required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz_rounded,
        color: PRIMARY_COLOR_1,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: (){
            onTapEdit();
          },
          value: 1,
          child: const Text("Edit"),
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          value: 2,
          child: const Text("Delete"),
        ),
      ],
    );
  }
}

class NameAndTimeView extends StatelessWidget {
  final String userName;
  final String time;
  const NameAndTimeView({
    Key? key, required this.userName, required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userName,style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
            color: PRIMARY_COLOR_1,
            fontWeight: FontWeight.w700),),
        const SizedBox(height: MARGIN_MEDIUM,),
        Text("${time} ago",style: const TextStyle(
    fontSize: TEXT_SMALL,
    fontWeight: FontWeight.w400,
    color: DONT_RECEIVE_OTP_COLOR,),)
      ],
    );
  }
}
class ProfileImageView extends StatelessWidget {
  final String profileImage;
  ProfileImageView({
    Key? key,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(profileImage),
      radius: MARGIN_LARGE,
    );
  }
}