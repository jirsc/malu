import 'package:flutter/material.dart';
import 'package:malu/utils/helpers/string_helper.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

enum InputType { email, mobileNumber, number, text }

class CustomInputText extends StatelessWidget {
  final bool enable;
  final InputType? inputType;
  final TextInputType? textInputType;
  final String? textError;
  final String? textHelper;
  final String? textHint;
  final String textKey;
  final String textLabel;
  final TextEditingController textEditingController;

  const CustomInputText(
      {Key? key,
      this.enable = true,
      this.inputType = InputType.text,
      this.textError,
      this.textHelper,
      this.textHint,
      this.textInputType = TextInputType.text,
      required this.textKey,
      required this.textLabel,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget _textInputWidget;

    switch (inputType) {
      case InputType.mobileNumber:
        String initialCountry = 'PH';
        PhoneNumber number = PhoneNumber(isoCode: 'PH');

        _textInputWidget = SizedBox(
          width: 450,
          child: Container(
            margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber value) {},
                    selectorConfig: const SelectorConfig(showFlags: true),
                    ignoreBlank: false,
                    initialValue: number,
                    textFieldController: textEditingController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 1),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                        enabled: enable,
                        errorText: isEmpty(value: textEditingController.text)
                            ? null
                            : textError,
                        helperText: textHelper,
                        hintText: textHint,
                        labelText: textLabel),
                  ),
                )
              ],
            ),
          ),
        );
        break;
      case InputType.email:
      case InputType.number:
      case InputType.text:
        _textInputWidget = SizedBox(
          width: 450,
          child: Container(
            margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 1),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1)),
                  enabled: enable,
                  errorText: isEmpty(value: textEditingController.text)
                      ? null
                      : textError,
                  helperText: textHelper,
                  hintText: textHint,
                  labelText: textLabel),
              key: Key(textKey),
              keyboardType: textInputType,
            ),
          ),
        );
        break;
      default:
        _textInputWidget = Container();
        break;
    }

    return _textInputWidget;
  }
}
