import 'package:authentication_repository/authentication_repository.dart';
import 'package:doeat/config/config.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doeat/core/core.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EmailInput(),
          const SizedBox(height: 16),
          _NameInput(controller: _controller),
          const SizedBox(height: 16),
          _NextButton(controller: _controller),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  bool _isValid(Email email) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'Invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: TextField(
            controller: controller,
            key: const Key('signUpForm_nameInput_textField'),
            onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
            decoration: InputDecoration(
              labelText: 'Name',
              helperText: '',
              errorText: state.name.invalid ? 'Invalid name' : null,
            ),
          ),
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  Expanded(
                    child: FullWidthButton(
                      'Next',
                      onPressed: () async {
                        Navigator.pop(
                          context,
                          User(
                            id: '',
                            email: state.email.value,
                            name: controller.text, //state.name.value,
                          ),
                        );
                      },
                      enabled: state.status.isValidated,
                      color: theme.primaryColor,
                      textColor: state.status.isValidated
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
