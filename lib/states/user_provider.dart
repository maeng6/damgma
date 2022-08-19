import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier{
  bool _userLoggedIn = false;

  void setUserAuth(bool authState){
    _userLoggedIn = authState;
    notifyListeners(); //이 해당 체인지노티파이어를 구독하고있는 위젯들한테 변경데이터를 알려줌.
    print(_userLoggedIn);
  }

  bool get userState => _userLoggedIn;

}