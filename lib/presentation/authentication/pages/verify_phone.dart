import 'package:flutter/material.dart';

import '../../shared_widgets/phone_input.dart';
import '../../shared_widgets/rectangular_button.dart';

class VerifyPhone extends StatefulWidget {
  final Function() onNext;
  const VerifyPhone({Key? key, required this.onNext}) : super(key: key);

  @override
  VerifyPhoneState createState() => VerifyPhoneState();
}

class VerifyPhoneState extends State<VerifyPhone> {
  var _isPhoneValid = false;
  late PhoneInput _phoneInput;
  late TextEditingController _phoneInputController;

  @override
  void initState() {
    super.initState();
    _phoneInputController = TextEditingController();
    _phoneInput = PhoneInput(
      _phoneInputController,
      isValid: (valid) => setState(() => _isPhoneValid = valid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Text(
                'Verify your\r\nphone number',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const SizedBox(height: 35.0),
        _phoneInput,
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RectangularButton(
                text: 'Next',
                isEnabled: _isPhoneValid,
                onPressed: () {
                  if (_isPhoneValid) {
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

  void reset(){
    _phoneInputController.text = '';
    _isPhoneValid = false;
  }
}
