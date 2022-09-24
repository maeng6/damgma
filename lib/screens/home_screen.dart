import 'package:beamer/beamer.dart';
import 'package:dangma/router/locations.dart';
import 'package:dangma/screens/home/items_page.dart';
import 'package:dangma/screens/home/map_page.dart';
import 'package:dangma/states/user_notifier.dart';
import 'package:dangma/widgets/expandable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          (context.read<UserNotifier>().userModel == null)
              ? Container()
              : MapPage(context.read<UserNotifier>().userModel!),
          Container(
            color: Colors.accents[3],
          ),
          Container(
            color: Colors.accents[5],
          ),
          Container(
            color: Colors.accents[6],
          )
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/$LOCATION_INPUT');
            },
            shape: CircleBorder(),
            height: 56,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
          MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            height: 56,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
          MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            height: 56,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          )
        ],
      ),
      appBar: AppBar(
        title: Text(
          '행신동',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(CupertinoIcons.nosign)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.text_justify))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        currentIndex: _bottomSelectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex == 0
                  ? Icons.home_filled
                  : Icons.home_outlined),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex == 0
                  ? Icons.workspaces_filled
                  : Icons.workspaces),
              label: '내 근처'),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex == 0
                  ? Icons.workspaces_filled
                  : Icons.workspaces),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex == 0
                  ? Icons.workspaces_filled
                  : Icons.workspaces),
              label: '채팅'),
        ],
      ),
    );
  }
}
