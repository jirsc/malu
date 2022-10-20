import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:malu/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/input_text.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  late bool _isFacebookLinked;
  late bool _isGoogleLinked;
  late int userPoints;
  late String userLevel;
  late TextEditingController _textEditingControllerName;
  late TextEditingController _textEditingControllerMobileNumber;
  late TextEditingController _textEditingControllerEmailAddress;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> initPackageInfo() async {
    //Itong part naman ay dapat nasa isang repository/sharedPref na lang.
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();

    //This initial values of these variables should be loaded from database.
    userPoints = 0;
    userLevel = "Bronze";
    _isFacebookLinked = false;
    _isGoogleLinked = false;

    _textEditingControllerName = TextEditingController();
    _textEditingControllerMobileNumber = TextEditingController();
    _textEditingControllerEmailAddress = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPackageInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Dapat ilabas itong variable na ito at ipunta sa initState.
    final user = context.select((AppBloc bloc) => bloc.state.user);
    //final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser!;
    final textTheme = Theme.of(context).textTheme;
    //_textEditingControllerName.text = user.name!;

    Widget profilePicture({required BoxConstraints constraints}) {
      try {
        return Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                margin: constraints.maxHeight > 450
                    ? EdgeInsets.only(
                        top: MediaQuery.of(context).size.height *
                            .175) //Portrait
                    : EdgeInsets.only(
                        top: MediaQuery.of(context).size.height *
                            .375), //Landscape
                child: Avatar(
                  photo: user.photo,
                  withBadge: true,
                  canChangeImage: true,
                  imageOnTapFunction: () {
                    SnackBar snackBar = const SnackBar(
                      content: Text(
                          'Upload new image function is not yet available'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //firebaseUser.updatePhotoURL("");
                  },
                )),
            Container(
              margin: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      "$userPoints ${userPoints > 1 ? "Points" : "Point"}",
                      style: textTheme.labelMedium),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('|', style: textTheme.labelMedium)),
                Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Text(userLevel, style: textTheme.labelMedium)),
                const Icon(
                  Icons.chevron_right,
                  size: 21,
                  color: Colors.black,
                ),
              ]),
            )
          ],
        );
      } catch (error) {
        log("profilePicture error: ${error.toString()}");
      }

      return Container();
    }

    Widget accountDetails() {
      try {
        return Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(1.0, 100.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Icon(Icons.check_circle_outline_outlined,
                          color: Colors.grey),
                    ),
                    Text(
                      "PIN Disabled",
                      style: TextStyle(
                          fontSize: textTheme.labelMedium?.fontSize,
                          color: Colors.grey[700]),
                    ),
                  ],
                )),

            //Todo: data in the textfields should be autoloaded.
            CustomInputText(
              inputType: InputType.text,
              textKey: "account_textInput_name",
              textEditingController: _textEditingControllerName,
              textError: "Name is empty",
              textHint: "Input Name..",
              textLabel: "Name",
            ),
            CustomInputText(
              inputType: InputType.mobileNumber,
              textKey: "account_textInput_mobileNum",
              textEditingController: _textEditingControllerMobileNumber,
              textError: "Mobile Number is empty",
              textHint: "Input Mobile Number..",
              textLabel: "Mobile #",
            ),
            CustomInputText(
              inputType: InputType.email,
              textKey: "account_textInput_email",
              textEditingController: _textEditingControllerEmailAddress,
              textError: "Email Address is empty",
              textHint: "Input Email Address..",
              textLabel: "Email Address",
            )
          ],
        );
      } catch (error) {
        log("accountDetails error: ${error.toString()}");
      }

      return Container();
    }

    Widget businessProfile() {
      try {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
              child: const Text("Profiles",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColor.appLinkBorderColor!))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Add a business profile',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColor.appLinkTextColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\nBetter manage your business here',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 10.0))
                            ]),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right,
                      size: 21,
                      color: AppColor.appLinkTextColor,
                    ),
                  ],
                ),
              ),
              onTap: () {
                SnackBar snackBar = const SnackBar(
                  content:
                      Text('"Add a business profile" is not yet available'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      } catch (error) {
        log("businessProfile error: ${error.toString()}");
      }

      return Container();
    }

    Widget linkedAccounts() {
      try {
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
              child: const Text("Linked Accounts",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColor.appLinkBorderColor!))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                    child: RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: ImageIcon(
                              AssetImage('assets/images/facebook-icon.png'),
                              size: 25,
                            )),
                        TextSpan(
                            text: '       Facebook',
                            style: Theme.of(context).textTheme.bodyMedium!)
                      ]),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: _isFacebookLinked,
                      onChanged: (value) {
                        setState(() {
                          _isFacebookLinked = value;
                        });
                      })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColor.appLinkBorderColor!))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                    child: RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: ImageIcon(
                              AssetImage('assets/images/google-icon.png'),
                              size: 30,
                            )),
                        TextSpan(
                            text: '       Google',
                            style: Theme.of(context).textTheme.bodyMedium!)
                      ]),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: _isGoogleLinked,
                      onChanged: (value) {
                        setState(() {
                          _isGoogleLinked = value;
                        });
                      })
                ],
              ),
            )
          ],
        );
      } catch (error) {
        log("linkedAccounts error: ${error.toString()}");
      }

      return Container();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(160.0),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    flexibleSpace: SafeArea(
                        child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/images/ad3.jpg'))),
                          ),
                        ),
                        Container(
                          color: const Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                      ],
                    )),
                    actions: [
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                              onTap: () {
                                SnackBar snackBar = const SnackBar(
                                  content: Text(
                                      'Saving of data is not yet available'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        accountDetails(),
                        businessProfile(),
                        linkedAccounts(),

                        //Bottom Part
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialog(
                                          title: "Aalis ka na? :(",
                                          content:
                                              "Balik ka ah? Magbonding momints pa tayo. <3",
                                          cancelButtonText: "I'll stay",
                                          confirmButtonText: 'Logout muna ako',
                                          onConfirm: () {
                                            Navigator.pop(context);
                                            context
                                                .read<AppBloc>()
                                                .add(AppLogoutRequested());
                                          });
                                    });
                              },
                              child: RichText(
                                text: TextSpan(children: [
                                  const WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.logout,
                                        size: 21,
                                      )),
                                  TextSpan(
                                      text: '  Log out',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!)
                                ]),
                              ),
                            )),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'version ${_packageInfo.version}, build ${_packageInfo.buildNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 11.0))
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            //This custom container will serve as the hidden background of the whole profile picture.
            //It is added to hide the other widgets when the user scroll-down the page.
            //Please optimize this part if you have a better solution for the UI. Thank you.
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 96.0,
              alignment: Alignment.topCenter,
              margin: constraints.maxHeight > 450
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .234) //Portrait
                  : EdgeInsets.only(
                      top: MediaQuery.of(context).size.height *
                          .480), //Landscape
            ),
            profilePicture(constraints: constraints)
          ],
        );
      },
    );
  }
}
