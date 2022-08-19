import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../screens/start_screen.dart';
import '../screens/home_screen.dart';

class HomeLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(),key:ValueKey('home'))];
  }

  @override
  // TODO: implement pathPatterns
  List get pathBlueprints => ['/'];
}

// class AuthLocation extends BeamLocation{
//   @override
//   List<BeamPage> buildPages(BuildContext context, RouteInformationSerializable state) {
//     return [BeamPage(child: StartScreen(),key:ValueKey('auth'))];
//   }
//
//   @override
//   // TODO: implement pathPatterns
//   List<Pattern> get pathPatterns => ['/auth'];
// }