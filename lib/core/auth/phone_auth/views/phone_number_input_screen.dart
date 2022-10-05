import 'package:authentication_repository/authentication_repository.dart';
import 'package:malu/config/config.dart';
import 'package:malu/constants/constants.dart';
import 'package:malu/core/auth/auth.dart';
import 'package:malu/models/models.dart';
import 'package:malu/utils/ui/icons/font_awesome_icons.dart';
import 'package:malu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({Key? key, required this.entryType})
      : super(key: key);

  final EntryType entryType;

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesome4.angle_left,
            color: Colors.grey.shade700,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Get Started',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
          ),
          BlocProvider(create: (context) => PhoneAuthBloc()),
        ],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildForm(state.status),
                    _buildButton(state.status),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(PhoneAuthStatus status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 21),
        _NumberField(
          controller: _controller,
          isValid: status.isInitial || status.isValid,
          entryType: widget.entryType,
        ),
        _ErrorMessage(
          isValid: status.isInitial || status.isValid,
        ),
      ],
    );
  }

  Widget _buildButton(PhoneAuthStatus status) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FullWidthButton(
                'Next',
                onPressed: () async {
                  if (status.isValid) {
                    if (await hasInternetConnection()) {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTPScreen(
                                phoneNumber: _controller.text,
                                entryType: widget.entryType,
                              )));
                    } else {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('No internet connection.'),
                            content:
                                Text('Sorry, pal. We can\'t send you a code.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                Widget: Text(
                                  'Oh, okay.',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                enabled: status.isValid,
                color: theme.primaryColor,
                textColor: status.isValid ? Colors.white : Colors.black87,
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (e) {
      print(e.message);
      //rethrow;
      return false;
    } catch (e) {
      rethrow;
    }
  }
}

class _NumberField extends StatefulWidget {
  const _NumberField({
    Key? key,
    required this.controller,
    this.isValid = true,
    required this.entryType,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isValid;
  final EntryType entryType;

  @override
  State<_NumberField> createState() => __NumberFieldState();
}

class __NumberFieldState extends State<_NumberField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Fetch content from the json file
  Future<Country> get _country async {
    final String jsonDataAsString =
        await rootBundle.loadString('assets/countries/country.json');
    final List data = jsonDecode(jsonDataAsString);
    List<Country> countries = data
        .map((element) => Country.fromJson(element as Map<String, dynamic>))
        .toList();
    return countries.firstWhere((country) => country.code == 'ph');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: widget.isValid ? Colors.black87 : Colors.red,
            ),
          ),
          child: TextButton(
            onPressed: () {},
            Widget: FutureBuilder(
                future: _country,
                builder: (context, AsyncSnapshot<Country> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        /* Image.asset(
                      'assets/countries/${_country.flag_4x3}',
                      height: 10,
                      width: 12,
                    ), */
                        SvgPicture.asset(
                          'assets/countries/${snapshot.data!.flag_4x3}',
                          height: 10,
                          width: 12,
                        ),
                        const Text(
                          ' +63',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Row(
                      children: [
                        Text(
                          snapshot.error.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: const [
                        SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          ' +63',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
        const SizedBox(width: 21),
        Expanded(
          child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: (text) => context
                  .read<PhoneAuthBloc>()
                  .add(NumberInputChanged(text: text)),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) async {
                if (widget.isValid) {
                  if (await hasInternetConnection()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(
                              phoneNumber: widget.controller.text,
                              entryType: widget.entryType,
                            )));
                  } else {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('No internet connection.'),
                          content:
                              Text('Sorry, pal. We can\'t send you a code.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              Widget: Text(
                                'Oh, okay.',
                                style: TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              /* onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "$value", which has length ${value.characters.length}.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }, */
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                //label: Text('910 123 4567'),
                hintText: '910 123 4567',
                hintStyle: const TextStyle(fontSize: 14),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: widget.isValid ? Colors.black87 : Colors.red,
                  ),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
              cursorColor: theme.primaryColor),
        ),
      ],
    );
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (e) {
      print(e.message);
      //rethrow;
      return false;
    } catch (e) {
      rethrow;
    }
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({Key? key, this.isValid = true}) : super(key: key);

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return isValid
        ? Container()
        : const Padding(
            padding: EdgeInsets.all(7),
            child: Text(
              'Check for extra or missing digits',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
  }
}
