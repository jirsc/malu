import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doeat/config/config.dart';
import 'package:doeat/constants/app_constants.dart';
import 'package:doeat/core/core.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
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
  final GlobalKey<NavigatorState> _loadingNavigatorKey =
      GlobalKey<NavigatorState>();
  late BuildContext dialogContext;
  late String _verificationCode;
  late String _verificationErrorMessage;
  late User _user;
  final TextEditingController _controller = TextEditingController();
  late final firebaseAuth.PhoneAuthCredential phoneCredential;
  final _firebaseAuth = firebaseAuth.FirebaseAuth.instance;
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
    //_controller.dispose();
  }

  _verifyPhone() async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+63${widget.phoneNumber}', //900 777 1122
      //timeout: Duration(seconds: 120),
      verificationCompleted:
          (firebaseAuth.PhoneAuthCredential credential) async {
        print('Verification Complete!');
        phoneCredential = credential;
        _controller.text = credential.smsCode.toString();
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
        //await _signInWithCredential(credential);
      },
      verificationFailed: (firebaseAuth.FirebaseAuthException e) {
        print(e.message);
        /* setState(() {
          _verificationErrorMessage = e.message.toString();
        }); */
      },
      codeSent: (String verificationID, int? resendToken) {
        // Update the UI - wait for the user to enter the SMS code

        // Test phone number from firebase auth
        if (widget.phoneNumber == "9007771122") {
          // String smsCode = 'xxxxxx';
          phoneCredential = firebaseAuth.PhoneAuthProvider.credential(
            verificationId: verificationID,
            smsCode: "123400",
          );
          _controller.text = "123400";
        }
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

  setProfile() async {
    _user = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
    /* Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PINInputScreen(phoneNumber: widget.phoneNumber)),
        (route) => false); */
  }

  Future<void> _signInWithCredential(
      firebaseAuth.PhoneAuthCredential credential) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        //barrierColor: Colors.black.withAlpha(30),
        builder: (BuildContext context) {
          dialogContext = context;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            //color: Colors.white,
            alignment: Alignment.center,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Material(
                  child: Row(
                    children: [
                      CircularProgressIndicator(
                        color: theme.primaryColorDark,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Loading..",
                        style: TextStyle(color: Colors.black87, fontSize: 21),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      await _firebaseAuth
          .signInWithCredential(credential)
          .then((current) async {
        if (firstLoginOf(current)) {
          db.collection('users').doc(current.user!.uid).set({
            //Use .updateEmail, .updateDisplayName or .updatePhoneNumber to update the basic info
            // in firebase auth credentials
            /*  'email': current.user!.email,
            'name': current.user!.displayName,
            'photo': current.user!.photoURL,
            'phoneNumber': current.user!.phoneNumber, */
            'balance': 0,
          }).onError((error, stackTrace) => print(error.toString()));
        }
        if (widget.entryType.isSignUp) {
          current.user!.updateEmail(_user.email ?? '');
          current.user!.updateDisplayName(_user.name ?? '');

          /* firebaseAuth.ActionCodeSettings actionCodeSettings =
              firebaseAuth.ActionCodeSettings(
            url:
                'https://www.example.com/cart?email=user@example.com&cartId=123',
            iOSBundleId: 'com.unrype.doeat',
            androidPackageName: 'com.unrype.doeat',
            androidInstallApp: true,
            androidMinimumVersion: '19',
            dynamicLinkDomain: '',
            handleCodeInApp: true,
          ); */
          // current.user!.sendEmailVerification()
        }

        Navigator.of(dialogContext, rootNavigator: true).pop();
      }).onError((error, stackTrace) {
        print(error.toString());
        Navigator.of(dialogContext, rootNavigator: true).pop();
      }).catchError((error, stackTrace) {
        print(error.toString());
        Navigator.of(dialogContext, rootNavigator: true).pop();
      });
    } on firebaseAuth.FirebaseAuthException catch (e) {
      Navigator.of(dialogContext, rootNavigator: true).pop();
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      Navigator.of(dialogContext, rootNavigator: true).pop();
      throw const LogInWithPhoneNumberFailure();
    }
  }

  bool firstLoginOf(firebaseAuth.UserCredential current) {
    var lastSignInTime = current
        .user!.metadata.lastSignInTime!.millisecondsSinceEpoch
        .toString();
    lastSignInTime = lastSignInTime.substring(0, lastSignInTime.length - 1);
    //print(lastSignInTime);
    var creationTime =
        current.user!.metadata.creationTime!.millisecondsSinceEpoch.toString();
    creationTime = creationTime.substring(0, creationTime.length - 1);
    //print(creationTime);
    return lastSignInTime == creationTime;
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
                  await setProfile();
                }
                _signInWithCredential(phoneCredential);

                /* context
                    .read<LoginCubit>()
                    .logInWithPhoneNumber(phoneCredential); */
                /* await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: v))
                    .then((value) async {
                  if (value.user != null) {
                    //setPassword(value.user!.uid);
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
