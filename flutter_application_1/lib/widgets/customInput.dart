import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChnaged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  bool isPassword;
  CustomInput(
      {this.hintText,
      this.onChnaged,
      this.onSubmitted,
      this.focusNode,
      this.isPassword,
      this.textInputAction});
  @override
  Widget build(BuildContext context) {
    bool _isPassword = isPassword ?? false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
          color: Colors.brown[200], borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText: _isPassword,
        focusNode: focusNode,
        onChanged: onChnaged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint text",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0)
            //hintStyle: TextStyle(color: Colors.white)
            ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
