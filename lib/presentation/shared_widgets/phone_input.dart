import 'package:collaction_app/presentation/authentication/utils/countries.dart';
import 'package:collaction_app/presentation/shared_widgets/country_search_dialog.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

/// Phone input with country search and selection
class PhoneInput extends StatefulWidget {
  /// Callback for realtime input validation
  final Function(bool)? isValid;

  /// Callback with generated phone number
  final Function(PhoneResponse)? onChange;

  final PhoneResponse? phone;

  const PhoneInput({Key? key, this.isValid, this.onChange, this.phone})
      : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  Country? _selected;

  final plugin = PhoneNumberUtil();
  final _phoneNumberController = TextEditingController();
  bool validatedNumber = false;

  @override
  void initState() {
    if (widget.phone != null) {
      final country =
          countries.where((country) => country.code == widget.phone?.country);

      /// Strip country
      if (country.isNotEmpty) {
        _selected = country.first;
      } else {
        _selected = countries.where((country) => country.code == "NL").first;
      }

      /// Strip phone
      final contact = widget.phone?.contact.split(" ");

      if (contact?.isNotEmpty == true && contact?.length == 2) {
        _phoneNumberController.text = contact?.last ?? "";
      }
    } else {
      _selected = countries.where((country) => country.code == "NL").first;
    }

    _phoneNumberController.addListener(() {
      if (_phoneNumberController.value.text.isNotEmpty) {
        setState(() {
          _validatePhone(_selected!, _phoneNumberController.value.text);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: _showCountrySelectDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  child: Row(
                    children: [
                      Image.asset(
                        'icons/flags/png/${_selected?.code.toLowerCase()}.png',
                        package: 'country_icons',
                        width: 24.0,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _selected?.dial_code ?? "",
                        style: const TextStyle(fontSize: 16.0),
                        key:const Key("dial_code"),
                      ),
                      const Icon(Icons.expand_more_outlined),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _phoneNumberController,
                  style: const TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Phone number', hintText: '00 00 00 00'),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 6),
                child: Text(
                  validatedNumber
                      ? 'We will send you a code to activate your account'
                      : (_phoneNumberController.value.text.isEmpty
                          ? 'Enter a valid phone number'
                          : 'Your phone number is not valid'),
                  style: TextStyle(
                      color: validatedNumber
                          ? kInactiveColor
                          : _phoneNumberController.value.text.isEmpty
                              ? kInactiveColor
                              : kErrorColor),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showCountrySelectDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: CountrySearch(
            onCountrySelected: _regionOnChange,
          ),
        );
      },
    );
  }

  void _regionOnChange(Country? value) {
    setState(() {
      _selected = value;
      _validatePhone(value!, _phoneNumberController.value.text);
    });
  }

  /// Return phone input validation result [isValid]
  void _triggerValidReturn(bool isValid) {
    if (widget.isValid != null) widget.isValid!(isValid);
  }

  /// Return phone number [phoneNumber]
  void _triggerPhoneReturn(PhoneResponse phoneNumber) {
    if (widget.onChange != null) widget.onChange!(phoneNumber);
  }

  /// Validate the combination of the country dial code
  /// and phone body
  Future<bool> _validatePhone(Country country, String number) async {
    final dialCode = int.tryParse(country.dial_code);
    final phoneNumber = "$dialCode ${number.trim()}";
    validatedNumber = await plugin.validate(phoneNumber, country.code);

    _triggerPhoneReturn(PhoneResponse(country.code, phoneNumber));
    _triggerValidReturn(validatedNumber);

    return validatedNumber;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}

class PhoneResponse {
  final String country;
  final String contact;

  PhoneResponse(this.country, this.contact);
}
