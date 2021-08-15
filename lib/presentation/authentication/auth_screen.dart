/**
 * TODO:
 * - Abstract into widgets --MOST IMPORTANT FOR MERGE
 * - New account flow --MOST IMPORTANT FOR MERGE
 * - Found account flow --CAN BE DONE IN SEPARATE TASK
 * - Not whitelisted number flow --CAN BE DONE IN SEPARATE TASK
 * - Invite friends flow --CAN BE DONE IN SEPARATE TASK
 */
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

import '../shared_widgets/custom_appbar.dart';
import '../shared_widgets/rectangular_button.dart';
import '../themes/constants.dart';
import 'utils/countries.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // All Pages
  final _pageController = PageController();
  double _currentPage = 0.0;

  // Page One
  Country? _selected;
  final countries = countryListJson
      .map((countryJson) => Country.fromJson(countryJson))
      .toList();
  final plugin = PhoneNumberUtil();
  final _phoneNumberController = TextEditingController();
  bool validatedNumber = false;

  // Page Two
  late FocusNode focusNode0, focusNode1, focusNode2, focusNode3;
  late TextEditingController digit0, digit1, digit2, digit3;

  @override
  void initState() {
    super.initState();
    // All pages
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });

    // Page One
    _selected = countries.where((country) => country.code == "NL").first;
    _phoneNumberController.addListener(() {
      if (_phoneNumberController.value.text.isNotEmpty) {
        setState(() {
          _validatePhone(_selected!, _phoneNumberController.value.text);
        });
      }
    });

    // Page Two
    focusNode0 = FocusNode();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    digit0 = TextEditingController();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
  }

  @override
  void dispose() {
    // Page Two
    focusNode0.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    digit0.dispose();
    digit1.dispose();
    digit2.dispose();
    digit3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _currentPage == 0
          ? CustomAppBar(
              context,
              closable: true,
            )
          : AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              children: [
                SizedBox(
                  height: 470.0,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
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
                            Row(
                              children: [
                                SizedBox(
                                  width: 115,
                                  child: DropdownButtonFormField<Country?>(
                                    onChanged: (value) =>
                                        _regionOnChange(value),
                                    icon:
                                        const Icon(Icons.expand_more_outlined),
                                    value: _selected,
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(fontSize: 20.0),
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 19.5,
                                        bottom: 19.5,
                                      ),
                                    ),
                                    items: countries
                                        .map(
                                          (country) =>
                                              DropdownMenuItem<Country?>(
                                            value: country,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'icons/flags/png/${country.code.toLowerCase()}.png',
                                                  package: 'country_icons',
                                                  width: 24.0,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  country.dial_code,
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    validator: (val) =>
                                        validatedNumber ? null : '',
                                    controller: _phoneNumberController,
                                    style: const TextStyle(fontSize: 20.0),
                                    decoration: const InputDecoration(
                                        labelText: 'Phone number',
                                        hintText: '00 00 00 00'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 6),
                                    child: Text(
                                      validatedNumber
                                          ? 'We will send you a code to activate your account'
                                          : _phoneNumberController
                                                  .value.text.isEmpty
                                              ? 'Enter a valid phone number'
                                              : 'Your phone number is not valid',
                                      style: TextStyle(
                                          color: validatedNumber
                                              ? kInactiveColor
                                              : _phoneNumberController
                                                      .value.text.isEmpty
                                                  ? kInactiveColor
                                                  : kErrorColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RectangularButton(
                                    text: 'Next',
                                    isEnabled: _isValidToContinue() && true,
                                    onPressed: !_isValidToContinue()
                                        ? null
                                        : () {
                                            _pageController.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                curve: Curves.easeIn);
                                          },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (index == 1) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Enter your \r\nverification code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.0),
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
                                    'We just sent you a text message with a 4-digit code to verify your account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kInactiveColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 45.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _digitField(
                                    digit0,
                                    focusNode0,
                                    (value) =>
                                        _changeFocus(value, focusNode1, null)),
                                _digitField(
                                    digit1,
                                    focusNode1,
                                    (value) => _changeFocus(
                                        value, focusNode2, focusNode0)),
                                _digitField(
                                    digit2,
                                    focusNode2,
                                    (value) => _changeFocus(
                                        value, focusNode3, focusNode1)),
                                _digitField(
                                    digit3,
                                    focusNode3,
                                    (value) =>
                                        _changeFocus(value, null, focusNode2)),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: Implement resend code function
                                    },
                                    child: const Text(
                                        'No code? Click here and we will send a new one',
                                        style: TextStyle(
                                            color: kAccentColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (index == 2) {
                        return const Text("Picture");
                      } else {
                        return const Text("Hello");
                      }
                    },
                  ),
                ),
                DotsIndicator(
                  position: _currentPage,
                  dotsCount: 3,
                  decorator: const DotsDecorator(
                    activeColor: kAccentColor,
                    color: Color(0xFFCCCCCC),
                    size: Size(12.0, 12.0),
                    activeSize: Size(12.0, 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Page One
  bool _isValidToContinue() {
    return validatedNumber;
  }

  void _regionOnChange(Country? value) {
    setState(() {
      _selected = value;
      _validatePhone(value!, _phoneNumberController.value.text);
    });
  }

  Future<bool> _validatePhone(Country country, String number) async {
    final dialCode = int.tryParse(country.dial_code);
    final phoneNumber = "$dialCode ${number.trim()}";
    return validatedNumber = await plugin.validate(phoneNumber, country.code);
  }

  // Page Two
  Padding _digitField(TextEditingController controller, FocusNode focus,
      ValueChanged<String> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.16,
        width: MediaQuery.of(context).size.width * 0.16,
        child: TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          showCursor: false,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 40),
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            counterText: "",
          ),
          focusNode: focus,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _changeFocus(String value, FocusNode? next, FocusNode? previous) {
    if (value.isNotEmpty && next != null) {
      next.requestFocus();
      return;
    }

    if (value.isEmpty && previous != null) {
      previous.requestFocus();
      return;
    }

    if (value.isNotEmpty && next == null) {
      // TODO: Create validation method on
    }
  }
}
