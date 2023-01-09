import 'package:flutter/material.dart';

class CustomUserImageWidget extends StatelessWidget {
  const CustomUserImageWidget({
    Key? key,  this.imageSize=50, required this.profilePicture,
  }) : super(key: key);
  final double imageSize;
  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("assets/images/active.png"),
            radius: 24,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/images/active.png"),
          )
        ],
      ),
    );
  }
}