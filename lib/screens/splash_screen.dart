import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExtendedImage.asset('assets/imgs/jua.jpg'),
              CircularProgressIndicator(
                color: Colors.green,
              )
            ],
          ),
        );

  }
}