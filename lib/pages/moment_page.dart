import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign_app/blocs/moment_bloc.dart';
import 'package:wechat_redesign_app/resources/dimens.dart';

import '../resources/colors.dart';
import '../viewitems/moment_item_view.dart';
import 'create_moment_page.dart';

class MomentPage extends StatelessWidget {
  const MomentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MomentBloc(),
      child: Scaffold(
        backgroundColor: CHAT_DETAIL_APP_BAR_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "Moments",
            style: TextStyle(
                color: PRIMARY_COLOR_1,
                fontSize: TEXT_BIG,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () => _navigateToCreateMomentPage(context),
              child: Padding(
                  padding: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
                  child: Image.asset("assets/images/moment_page_icon.png",width: MARGIN_XLARGE,height: MARGIN_XLARGE,)),
            ),
          ],
        ),
        body: Container(
          child: Consumer<MomentBloc>(
            builder: (context, bloc, child) => ListView.separated(
                padding: const EdgeInsets.symmetric(
                    vertical: MARGIN_LARGE, horizontal: MARGIN_LARGE),
                itemBuilder: (context, index) {
                  return MomentItemView(
                    moment: bloc.moments?[index],
                    onTapDelete: (momentId) {
                      bloc.onTapDeletePost(momentId);
                    },
                    onTapEdit: (momentId) {
                      debugPrint("Moment Id===>$momentId");
                      Future.delayed(const Duration(milliseconds: 1000))
                          .then((value) {
                        _navigateToEditMomentPage(context, momentId);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: MARGIN_XLARGE,
                  );
                },
                itemCount: bloc.moments?.length ?? 0),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToEditMomentPage(BuildContext context, int momentId) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateMomentPage(
                    momentId: momentId,
                  )));

  Future<dynamic> _navigateToCreateMomentPage(BuildContext context) =>
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateMomentPage()));
}
