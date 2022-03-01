import 'package:doeat/config/config.dart';
import 'package:doeat/constants/constants.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
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
  bool isEnabled = false;

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

  List<Country> countries = [];
  Country _country = Country.empty;

  // Fetch content from the json file
  Future<void> getCountries() async {
    final String jsonDataAsString =
        await rootBundle.loadString('assets/countries/country.json');
    final List data = jsonDecode(jsonDataAsString);
    setState(() {
      countries = data
          .map((element) => Country.fromJson(element as Map<String, dynamic>))
          .toList();
      _country = countries.firstWhere((country) => country.code == 'ph');
    });
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 21),
                _NumberField(
                  controller: _controller,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FullWidthButton(
                        'Next',
                        onPressed: () {
                          /* return Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WelcomeScreen())); */
                          //return Navigator.of(context).pop();
                        },
                        enabled: isEnabled,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NumberField extends StatefulWidget {
  const _NumberField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

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
          shape: const Border(bottom: BorderSide(width: 1)),
          child: TextButton(
            onPressed: () {},
            child: FutureBuilder(
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
                            color: Colors.black87,
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
              onChanged: (text) => setState(() {
                    if (text.length < 10) {
                    } else {}
                  }),
              onSubmitted: (String value) async {
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
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                //label: Text('910 123 4567'),
                hintText: '910 123 4567',
                hintStyle: TextStyle(fontSize: 14),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.black87,
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
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
}
