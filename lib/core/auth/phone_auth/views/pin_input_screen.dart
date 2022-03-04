import 'package:doeat/constants/app_constants.dart';
import 'package:doeat/core/core.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PINInputScreen extends StatefulWidget {
  const PINInputScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  _PINInputScreenState createState() => _PINInputScreenState();
}

class _PINInputScreenState extends State<PINInputScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _controller = TextEditingController();
  late final PhoneAuthCredential phoneCredential;

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
                  'Verify +63 ${widget.phoneNumber}',
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
                onCompleted: (v) async {
                  try {
                    context
                        .read<LoginCubit>()
                        .logInWithPhoneNumber(phoneCredential);
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
                    /* _scaffoldkey.currentState!
                        .showSnackBar(SnackBar(content: Text('invalid OTP'))); */
                    const SnackBar(content: Text('Invalid OTP'));
                  }
                },
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
