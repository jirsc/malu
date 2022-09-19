import 'package:malu/config/config.dart';
import 'package:malu/constants/constants.dart';
import 'package:malu/core/core.dart';
import 'package:malu/utils/utils.dart';
import 'package:malu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final ScreenSize screenSize = ScreenSize(width: 0, height: 0);

  @override
  Widget build(BuildContext context) {
    screenSize.width = MediaQuery.of(context).size.width;
    screenSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            FontAwesome4.angle_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [],
        ),
      ),
      body: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Authentication Failure'),
                  ),
                );
            }
          },
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            color: theme.primaryColor,
            alignment: Alignment.center, //const Alignment(0, 1 / 2),
            /* decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ), */
            child: Padding(
              padding: EdgeInsets.only(top: screenSize.height / 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text('created by'),
                      Image.asset(
                        'assets/images/unrype_logo_small_transparent.png',
                        height: 93,
                      ),
                    ],
                  ),
                  LoginButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  const LoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        _FacebookLoginButton(),
        const SizedBox(height: 12),
        _GoogleLoginButton(),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: const Divider(
                  color: Colors.white,
                  height: 70,
                ),
              ),
            ),
            const Text(
              "or",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: const Divider(
                    color: Colors.white,
                    height: 70,
                  )),
            ),
          ],
        ),
        _PhoneLoginButton(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithIconButton(
      const Text(
        'Continue with Google',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        return context.read<LoginCubit>().logInWithGoogle();
      },
      isIconImage: true,
      image: Image.asset(
        'assets/images/google-icon.png',
        height: 40.0,
        width: 40.0,
      ),
    );
  }
}

/* class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        key: const Key('loginForm_googleLogin_elevatedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          primary: const Color(0xFFffffff),
        ),
        //icon: Icon(FontAwesomeIcons.google, color: Colors.indigo.shade400),
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/google-icon.png',
                height: 40.0,
                width: 40.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

class _FacebookLoginButton extends StatelessWidget {
  const _FacebookLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithIconButton(
      const Text(
        'Continue with Facebook',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        return context.read<LoginCubit>().logInWithFacebook();
      },
      padding: const EdgeInsets.only(left: 7),
      isIconImage: true,
      image: Image.asset(
        'assets/images/facebook-icon.png',
        height: 25.0,
        width: 25.0,
      ),
    );
  }
}

/* class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        key: const Key('loginForm_facebookLogin_elevatedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          primary: const Color(0xFFffffff),
        ),
        onPressed: () => context.read<LoginCubit>().logInWithFacebook(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Image.asset(
                  'assets/images/facebook-icon.png',
                  height: 25.0,
                  width: 25.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Continue with Facebook',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

class _PhoneLoginButton extends StatelessWidget {
  const _PhoneLoginButton({Key? key}) : super(key: key);

  /* void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return TextWithIconButton(
      const Text(
        'Continue with Mobile Number',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PhoneNumberInputScreen(
            entryType: EntryType.login,
          ),
        ));
      },
      icon: const Icon(
        FontAwesome4.phone,
        color: Colors.black,
      ),
    );
  }
}

/* class _PhoneLoginButton extends StatelessWidget {
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        key: const Key('loginForm_phoneLogin_elevatedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          primary: const Color(0xFFffffff),
        ),
        onPressed: () => _pushPage(
          context,
          const PhoneNumberInputScreen(
            entryType: EntryType.login,
          ),
        ),
        //onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesome4.phone,
                color: Colors.black,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Continue with Mobile Number',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */
