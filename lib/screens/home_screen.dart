import 'package:dangma/screens/home/items_page.dart';
import 'package:dangma/states/user_provider.dart';
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
          Container(
            color: Colors.accents[0],
          ),
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
      appBar: AppBar(
        title: Text('행신동',
        style: Theme.of(context).appBarTheme.titleTextStyle,),
        actions: [
          IconButton(
              onPressed: (){
                context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.nosign)),
          IconButton(
              onPressed: (){
                context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: (){
                context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.text_justify))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        currentIndex: _bottomSelectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex==0? Icons.home_filled : Icons.home_outlined),
            label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex==0? Icons.workspaces_filled : Icons.workspaces),
            label: '내 근처'
          ),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex==0? Icons.workspaces_filled : Icons.workspaces),
              label: '채팅'
          ),
          BottomNavigationBarItem(
              icon: Icon(_bottomSelectedIndex==0? Icons.workspaces_filled : Icons.workspaces),
              label: '채팅'
          ),
        ],
      ),
    );
  }
}
