import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _controller = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+63${widget.phone}', //900 777 1122
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('Verification Complete!');
          /* await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              setPassword(value.user!.uid);
            }
          }); */
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxx';
          _controller.text = '123400';
          /* setState(() {
            _verificationCode = verficationID;
          }); */
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  setPassword(uid) {
    /* Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordScreen(widget.phone, uid)),
        (route) => false); */

    /*Map userDetails={
      "mobile":widget.phone,
      "password":"1234",
    };

    dbRef.child(uid).set(userDetails).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(uid)),
              (route) => false);
    }).onError((error, stackTrace) {
      _scaffoldkey.currentState!
          .showSnackBar(SnackBar(content: Text('${error.toString()}')));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesome4.angle_left,
            color: Colors.grey.shade700,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'OTP Verification',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Verify +63 ${widget.phone}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinCodeTextField(
                appContext: context,
                controller: _controller,
                length: 6,
                //obscureText: true,
                //obscuringCharacter: '*',
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                /* onCompleted: (v) async {
                  try {
                    /* await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: v))
                        .then((value) async {
                      if (value.user != null) {
                        //setPassword(value.user!.uid);

                        /// TODO:

                      }
                    }); */
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldkey.currentState!
                        .showSnackBar(SnackBar(content: Text('invalid OTP')));
                  }
                }, */
                onChanged: (value) {
                  print(value);
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
