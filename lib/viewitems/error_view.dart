import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class PostDescriptionErrorView extends StatelessWidget {
  const PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Visibility(
        visible: false,
        child: const Text(
          "Post should not be empty",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: TEXT_REGULAR,
          ),
        ),

    );
  }
}