import 'package:dangma/states/user_provider.dart';
import 'package:dangma/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constraints/common_size.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  TextEditingController _phoneNumberController = TextEditingController(text:"010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){

        Size size = MediaQuery.of(context).size;
        final inputBorder =OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey
            )
        );

        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
            appBar: AppBar(
              title: Text('전화번호 로그인',
              style: Theme.of(context).appBarTheme.titleTextStyle ,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(common_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ExtendedImage.asset(
                        'assets/imgs/padlock.png',
                      width: size.width*0.15,
                      height: size.width*0.15,
                      ),
                      SizedBox(
                        width: common_sm_padding,
                      ),
                      Text('토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.',
                      style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  SizedBox(
                    height: common_padding,
                  ),
                  TextFormField(
                    validator: (phoneNumber){
                      if(phoneNumber!=null && phoneNumber.length==13){
                        return null;
                      } else{
                        return '똑바로입력해라!';
                      }
                    },
                    controller: _phoneNumberController ,
                    inputFormatters: [
                      MaskedInputFormatter("000 0000 0000")
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: inputBorder,
                      focusedBorder: inputBorder
                    ),
                  ),
                  SizedBox(
                    height: common_sm_padding,
                  ),
                  TextButton(
                      onPressed: (){
                        if(_formKey.currentState!=null) {
                          bool passed = _formKey.currentState!.validate();
                          print(passed);
                          if(passed)
                            setState((){});
                            _verificationStatus = VerificationStatus.codeSent;
                        }
                      },
                      child: Text('인증문자 발송')
                  ),
                  SizedBox(
                    height: common_padding,
                  ),
                  AnimatedOpacity(
                    curve: Curves.easeOut,
                    opacity: (_verificationStatus == VerificationStatus.none)?0:1,
                    duration: duration,
                    child: AnimatedContainer(
                      curve: Curves.easeOut,
                      duration: duration,
                      height: getVerificationHeight(_verificationStatus),
                      child: TextFormField(
                        controller: _codeController ,
                        inputFormatters: [
                          MaskedInputFormatter("000000")
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: inputBorder,
                            focusedBorder: inputBorder
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: duration,
                    height: getVerificationButtonHeight(_verificationStatus),
                    child: TextButton(
                        onPressed: (){
                          attemptVerify();
                        },
                        child: (_verificationStatus == VerificationStatus.verifying)?CircularProgressIndicator(
                          color: Colors.white,
                        ):Text('인증')
                    ),
                  )
                ],
              ),
            ),
      ),
          ),
        );
      }
    );
  }

  double getVerificationHeight(VerificationStatus status){
    switch(status){
      case VerificationStatus.none:
      return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
      return 60+common_sm_padding;
    }
  }


  double getVerificationButtonHeight(VerificationStatus status){
    switch(status){
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify() async{
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });

    context.read<UserProvider>().setUserAuth(true);
    logger.d('${context.read<UserProvider>().userState}');

  }

  _getAddress() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address')??"";
    logger.d('address from prefs - $address');
  }

}

enum VerificationStatus{
  none, codeSent, verifying, verificationDone
}
