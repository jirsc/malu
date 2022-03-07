import 'package:formz/formz.dart';

/// Validation errors for the [Name] [FomzInput].
enum NameValidationError {
  /// Generic invalid error.
  invalid,
  empty
}

/// {@template name}
/// Form input for an name input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  // Call super.pure to represent an unmodified form input.
  /// {@macro name}
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  /// {@macro name}
  const Name.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$",
  );

  // Override validator to handle validating a given input value.
  @override
  NameValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return NameValidationError.empty;
    } else if (_nameRegExp.hasMatch(value ?? '')) {
      return null;
    }
    return NameValidationError.invalid;
  }
}
