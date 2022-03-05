import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doeat/constants/app_constants.dart';
import 'package:doeat/core/core.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.entryType,
  }) : super(key: key);

  final String phoneNumber;
  final EntryType entryType;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _controller = TextEditingController();
  late final PhoneAuthCredential phoneCredential;
  final FirebaseFirestore db = FirebaseFirestore.instance;

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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+63${widget.phoneNumber}', //900 777 1122
      //timeout: Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('Verification Complete!');
        phoneCredential = credential;
        /* if (widget.entryType.isLogin) {
            context.read<LoginCubit>().logInWithPhoneNumber(credential);
          } else {} */
        /* await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              setPassword(value.user!.uid);
            }
          }); */
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationID, int? resendToken) {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';
        phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationID,
          smsCode: smsCode,
        );
        _controller.text = '123400';
        /* setState(() {
          _verificationCode = verificationID;
        }); */
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        /* setState(() {
            _verificationCode = verificationID;
          }); */
      },
    );
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      FirebaseAuth.instance.signInWithCredential(credential).then((current) {
        var lastSignInTime = current
            .user!.metadata.lastSignInTime!.millisecondsSinceEpoch
            .toString();
        lastSignInTime = lastSignInTime.substring(0, lastSignInTime.length - 1);
        //print(lastSignInTime);
        var creationTime = current
            .user!.metadata.creationTime!.millisecondsSinceEpoch
            .toString();
        creationTime = creationTime.substring(0, creationTime.length - 1);
        //print(creationTime);
        if (lastSignInTime == creationTime) {
          db.collection('users').doc(current.user!.uid).set({
            'email': current.user!.email,
            'name': current.user!.displayName,
            'photo': current.user!.photoURL,
            'phoneNumber': current.user!.phoneNumber,
            'balance': 0,
          }).onError((error, stackTrace) => print(error.toString()));
        }
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  setPIN() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PINInputScreen(phoneNumber: widget.phoneNumber)),
        (route) => false);

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
          iconSize: 30,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInputField(),
            _buildResendCodeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the 6-digit code sent to',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '+63 ${widget.phoneNumber}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
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
            onCompleted: (v) async {
              try {
                if (widget.entryType.isSignUp) {
                  //setPIN();
                }
                await _signInWithCredential(phoneCredential);
                /* context
                    .read<LoginCubit>()
                    .logInWithPhoneNumber(phoneCredential); */
                /* await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: v))
                    .then((value) async {
                  if (value.user != null) {
                    //setPassword(value.user!.uid);

                    /// TODO:

                  } 
                });*/
              } catch (e) {
                FocusScope.of(context).unfocus();
                /* _scaffoldkey.currentState!
                            .showSnackBar(SnackBar(content: Text('invalid OTP'))); */
                const SnackBar(content: Text('Invalid OTP'));
              }
            },
            onChanged: (value) {
              print(value);
              //setState(() {});
            },
          ),
        )
      ],
    );
  }

  Widget _buildResendCodeButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Didn\'t receive it?'),
        Text(
          'Request a new code in 00:27',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
