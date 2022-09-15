import 'package:dangma/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constraints/common_size.dart';
import '../../constraints/shared_pref_keys.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final  auth=FirebaseAuth.instance ;
  TextEditingController _phoneNumberController = TextEditingController(text:"010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  String? _verificationID;
  int? _forceResendingToken;

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
                      onPressed: () async {
                        if(_verificationStatus==VerificationStatus.codeSending)
                          return;

                        if(_formKey.currentState!=null) {
                          bool passed = _formKey.currentState!.validate();
                          print(passed);
                          if(passed){
                            String phoneNum = _phoneNumberController.text;
                          phoneNum = phoneNum.replaceAll(' ', '');
                          phoneNum = phoneNum.replaceFirst('0', '');

                          setState(() {
                            _verificationStatus = VerificationStatus.codeSending;
                          });

                          await auth.verifyPhoneNumber(
                            phoneNumber: '+82$phoneNum',
                            forceResendingToken: _forceResendingToken,
                            verificationCompleted: (PhoneAuthCredential credential) async {
                              await auth.signInWithCredential(credential);
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {  },
                            codeSent: (String verificationId, int? forceResendingToken) async{
                              setState(() {
                                _verificationStatus = VerificationStatus.codeSent;
                              });

                              _verificationID = verificationId;
                              _forceResendingToken = forceResendingToken;

                            },
                            verificationFailed: (FirebaseAuthException error) {
                              logger.d(error.message);

                              setState(() {
                                _verificationStatus = VerificationStatus.none;
                              });
                            });
                          }
                          }
                        },
                      child: (_verificationStatus==VerificationStatus.codeSending)? SizedBox(
                        height: 26,
                          width: 26,
                        child: CircularProgressIndicator(
                          color: Colors.white ,
                        ),
                      ): Text('인증문자 발송')
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
      case VerificationStatus.codeSending:
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
      case VerificationStatus.codeSending:
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

  try{
  // Create a PhoneAuthCredential with the code
  PhoneAuthCredential credential =
  PhoneAuthProvider.credential(
  verificationId: _verificationID!,
  smsCode: _codeController.text);

  // Sign the user in (or link) with the credential
  await auth.signInWithCredential(credential);
  }catch (e){
    logger.e('verification failed!');
    SnackBar snackBar = SnackBar(content: Text('입력하신 코드가 틀려요!'),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
  }

  _getAddress() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString(SHARED_ADDRESS)??"";
    double lat = prefs.getDouble(SHARED_LAT)??0;
    double lon = prefs.getDouble(SHARED_LON)??0;
  }

}

enum VerificationStatus{
  none,codeSending, codeSent, verifying, verificationDone
}
