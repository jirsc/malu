import 'package:doeat/app/views/welcome_screen.dart';
import 'package:doeat/constants/constants.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({Key? key, required this.entryType})
      : super(key: key);

  final EntryType entryType;

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  late TextEditingController _controller;
  bool isDisabled = true;

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
                SizedBox(height: 21),
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
                        disabled: isDisabled,
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

class _NumberField extends StatelessWidget {
  const _NumberField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('FLAG +63'), //Ang pogi ko
        SizedBox(width: 21),
        Expanded(
          child: TextField(
            controller: controller,
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
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
              label: Text('910 123 4567'),
            ),
          ),
        ),
      ],
    );
  }
}
