import 'package:flutter/material.dart';

import '../themes/constants.dart';

class RectangularButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final bool isEnabled;

  const RectangularButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isEnabled = false,
    this.height = 50.0,
  }) : super(key: key);

  @override
  _RectangularButtonState createState() => _RectangularButtonState();
}

class _RectangularButtonState extends State<RectangularButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder?>(
            const RoundedRectangleBorder()),
        backgroundColor: widget.isEnabled
            ? MaterialStateProperty.all<Color?>(kEnabledButtonColor)
            : MaterialStateProperty.all<Color?>(kDisabledButtonColor),
        minimumSize: MaterialStateProperty.all<Size?>(
            Size(double.infinity, widget.height)),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
            color: kSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.0),
      ),
    );
  }
}
