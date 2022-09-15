import 'package:dangma/states/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constraints/common_size.dart';
import '../../utils/logger.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){

        Size size = MediaQuery.of(context).size;

        final imageSize = size.width-32;
        final sizeOfPosImg = imageSize * 0.1;

        return  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: common_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('토마토마켓',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color:Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Stack(
                    children: [
                      Image.asset('assets/imgs/carrot_intro.png'),
                      Positioned(
                        width: sizeOfPosImg,
                          left: imageSize*0.45,
                          top: imageSize*0.45,
                          height:sizeOfPosImg ,
                          child: Image.asset('assets/imgs/carrot_intro_pos.png')
                      ),
                    ],
                  ),
                ),
                Text('우리 동네 중고 직거래 토마토마켓',
                    style: Theme.of(context).textTheme.headline6
                ),
                Text('토마토마켓은 동네 직거래 마켓이에요.\n'
                    '내 동네를 설정하고 시작해보세요.',
                    style: Theme.of(context).textTheme.subtitle1
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () async{
                        context.read<PageController>().animateToPage(
                            1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn
                        );
                      },
                      child: Text('내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        );
      },
    );
  }
}
