import 'package:collaction_app/presentation/shared_widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phone Input Widget:', () {
    Widget _wrapInMaterial(Widget widget) {
      return MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      );
    }

    testWidgets('Initial Phone input is split to country and contact',
        (WidgetTester tester) async {
      final phoneInput =
          PhoneInput(phone: PhoneResponse("UG", "256 778916353"));

      await tester.pumpWidget(_wrapInMaterial(phoneInput));

      final phoneField = find.byType(PhoneInput);
      expect(phoneField, findsOneWidget);

      final textField =
          tester.widget<TextFormField>(find.byType(TextFormField));

      expect(textField.controller?.text, "778916353");

      final dialCode = tester.widget<Text>(find.byKey(const Key("dial_code")));
      expect(dialCode.data, "+256");
    });

    testWidgets('Invalid Phone number triggers callback with false',
        (WidgetTester tester) async {
      final phoneInput = PhoneInput(
          phone: PhoneResponse("NL", "31 77891635"),
          isValid: (valid) => print(valid));

      await tester.pumpWidget(_wrapInMaterial(phoneInput));

      final phoneField = find.byType(PhoneInput);
      expect(phoneField, findsOneWidget);
      await tester.pump();

      /// TODO - Trigger validation callback
    });
  });
}
