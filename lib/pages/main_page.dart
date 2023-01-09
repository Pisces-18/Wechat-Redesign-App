import 'package:flutter/material.dart';
import 'package:wechat_redesign_app/pages/moment_page.dart';
import 'package:wechat_redesign_app/pages/setting_page.dart';

import 'chat_page.dart';
import 'contacts_page.dart';
import 'me_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: _myPage,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MomentPage(),
          ChatPage(),
          ContactsPage(),
          MePage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 8,
        shadowColor: Colors.black,
        child: BottomNavigationBar(
          //fixedColor: PRIMARY_COLOR_1,
          //elevation: 5,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _myPage.jumpToPage(_selectedIndex);
            });
          },
          selectedIconTheme: const IconThemeData(color: Colors.deepPurple),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              // icon: ImageIcon(AssetImage("assets/images/movies.png")),
              icon: Icon(Icons.newspaper),
              label: "Moment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts_sharp),
              label: "Contacts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: "Me",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
