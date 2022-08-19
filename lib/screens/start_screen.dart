import 'package:beamer/beamer.dart';
import 'package:dangma/screens/start/auth_page.dart';
import 'package:dangma/screens/start/intro_page.dart';
import 'package:dangma/screens/start/address_page.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children:[
          IntroPage(_pageController),
          AddressPage(),
          AuthPage()
    ]
      ),
    );
  }
}
