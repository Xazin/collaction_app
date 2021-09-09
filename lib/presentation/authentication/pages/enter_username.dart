import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared_widgets/rectangular_button.dart';
import '../../themes/constants.dart';

/// Username entry
class EnterUserName extends StatefulWidget {
  final Function() onNext;

  const EnterUserName({Key? key, required this.onNext}) : super(key: key);

  @override
  _EnterVerificationCodeState createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterUserName> {
  var _isNameValid = false;
  late TextEditingController _usernameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                'How should we call\r\n you?',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: const [
            Expanded(
              child: Text(
                'Enter your first name or use a recognizable name that others can identify you by',
                textAlign: TextAlign.center,
                style: TextStyle(color: kInactiveColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 45.0),
        Form(
          key: _formKey,
          onChanged: () => setState(
              () => _isNameValid = _formKey.currentState?.validate() == true),
          child: TextFormField(
            controller: _usernameController,
            onChanged: (name) {},
            style: const TextStyle(fontSize: 20.0),
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: 'Your name',
                helperText: "Use your real name or choose a user name",
                focusColor: kAccentColor),
            validator: _validate,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_.-]")),
            ],
          ),
        ),
        const SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RectangularButton(
                text: 'Next',
                isEnabled: _isNameValid,
                onPressed: () {
                  if (_isNameValid) {
                    widget.onNext();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.length < 4 || value.length > 20) {
      return "Username should be between 4 and 60 characters long";
    }

    if(!value.startsWith(RegExp("[a-zA-Z0-9]"))){
      return "Username should start with a letter or number";
    }

    return null;
  }

  @override
  void dispose() {
    // Page Two
    _usernameController.dispose();

    super.dispose();
  }
}
