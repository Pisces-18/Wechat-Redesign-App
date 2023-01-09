import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign_app/pages/home_page.dart';
import 'package:wechat_redesign_app/pages/me_page.dart';
import 'package:wechat_redesign_app/pages/qr_page.dart';

import 'data/models/authentication_model_Impl.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final _authenticationModel = AuthenticationModelImpl();
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


