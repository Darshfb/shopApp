import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? onPressed;
  double? minWidth;
  Color? backgroundColor;
  Widget? child;

  CustomButton(
      {this.onPressed, this.minWidth, this.backgroundColor, this.child});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: backgroundColor,
      minWidth: minWidth,
      onPressed: onPressed,
      child: child,
    );
  }
}
