import 'package:authentication_repository/authentication_repository.dart';
import 'package:doeat/config/config.dart';
import 'package:doeat/constants/app_constants.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doeat/core/core.dart';
import 'package:formz/formz.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: WelcomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: const AppEntryButtons(),
              //child: const LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //var roundnessFactor = 50.0;

    var path = Path();

    //path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.75);
    path.cubicTo(size.width * 0.43, size.height * 0.7, size.width * 0.75,
        size.height * 0.85, size.width, size.height * 0.77);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width - roundnessFactor, size.height);
    //path.quadraticBezierTo(size.width, size.height, size.width, size.height - roundnessFactor);
    /* path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width - 10, roundnessFactor,
        size.width - roundnessFactor * 1.5, roundnessFactor * 1.5);
    path.lineTo(
        roundnessFactor * 0.6, size.height * 0.33 - roundnessFactor * 0.3);
    path.quadraticBezierTo(
        0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor); */

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class AppEntryButtons extends StatelessWidget {
  const AppEntryButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter, //const Alignment(0, 1 / 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: [
              /*Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),*/
              FullWidthButton(
                'Log In',
                onPressed: () {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }),
                  );
                },
                textColor: Colors.white,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 12),
              FullWidthButton(
                'New to DoEat? Sign up!',
                onPressed: () {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const PhoneNumberInputScreen(
                          entryType: EntryType.signUp);
                    }),
                  );
                },
                border: BorderSide(width: 1, color: Colors.black87),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
