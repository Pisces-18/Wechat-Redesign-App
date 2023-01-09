import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/setting_bloc.dart';
import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewitems/custom_primary_button_view.dart';
import 'home_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>SettingBloc(),
      child: Scaffold(
        body: Center(
          child: Consumer<SettingBloc>(
            builder: (context, bloc, child) => GestureDetector(
              onTap: (){
                bloc.onTapLogout().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                }).catchError((error){
                  debugPrint("Log out Error===>$error");
                });
              },
              child: CustomPrimaryButtonView(
                label: LBL_LOG_OUT,
                themeColor: PRIMARY_COLOR_1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
