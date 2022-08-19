import 'package:dangma/router/locations.dart';
import 'package:dangma/screens/start/auth_page.dart';
import 'package:dangma/screens/start_screen.dart';
import 'package:dangma/screens/splash_screen.dart';
import 'package:dangma/states/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dangma/utils/logger.dart';
import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
        pathBlueprints: ['/'],
        check: (context, location) {
          return context.watch<UserProvider>().userState;
        },
        showPage: BeamPage(child: StartScreen())
    ),
  ],
  locationBuilder:
  BeamerLocationBuilder(beamLocations: [HomeLocation(),]),
);

void main() {

  logger.d('My first log by logger');
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
    } else if (snapshot.hasData) {
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
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          hintColor: Colors.grey[350],
          fontFamily: 'DoHyeon',
          textTheme: TextTheme(
            // headline3: TextStyle(fontFamily: 'DoHyeon'),
            button: TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
                minimumSize: Size(48, 48)),
          ),
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(
              color: Colors.black87
            ),
              elevation: 2,
              backgroundColor: Colors.white,
              titleTextStyle:
                  TextStyle(fontFamily: 'DoHyeon', color: Colors.black87)),
          primarySwatch: Colors.red,
          // fontFamily: 'DoHyeon'
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
