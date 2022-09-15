import 'package:dangma/router/locations.dart';
import 'package:dangma/screens/start_screen.dart';
import 'package:dangma/screens/splash_screen.dart';
import 'package:dangma/states/user_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dangma/utils/logger.dart';
import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
        pathBlueprints: [
          ...HomeLocation().pathBlueprints,
          ...InputLocation().pathBlueprints,
          ...ItemLocation().pathBlueprints
        ],
        check: (context, location) {
          return context.watch<UserNotifier>().user != null;
        }, //check가 false이면 showPage를 보여줌.
        showPage: BeamPage(child: StartScreen())),
  ],
  locationBuilder: BeamerLocationBuilder(
      beamLocations: [HomeLocation(), InputLocation(), ItemLocation()]),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  logger.d('My first log by logger');
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 300), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _splashLoadingWidget(snapshot),
          );
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('error occur while loading');
      return Text('');
    } else if (snapshot.connectionState == ConnectionState.done) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserNotifier>(
      create: (BuildContext context) {
        return UserNotifier();
      },
      child: MaterialApp.router(
        theme: ThemeData(
            hintColor: Colors.grey[350],
            fontFamily: 'DoHyeon',
            textTheme: TextTheme(
                // headline3: TextStyle(fontFamily: 'DoHyeon'),
                button: TextStyle(color: Colors.white),
                subtitle1: TextStyle(color: Colors.black87, fontSize: 15),
                subtitle2: TextStyle(color: Colors.grey, fontSize: 13),
                bodyText2: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            inputDecorationTheme: InputDecorationTheme(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white,
                  minimumSize: Size(48, 48)),
            ),
            appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.black87),
                elevation: 2,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                titleTextStyle:
                    TextStyle(fontFamily: 'Dohyeon', color: Colors.black87)),
            primarySwatch: Colors.red,
            // fontFamily: 'DoHyeon'
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black54,
            )),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
