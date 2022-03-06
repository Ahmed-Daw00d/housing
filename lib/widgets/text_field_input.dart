import 'package:flutter/material.dart';
import 'package:housing/utils/colors.dart';

class TextFieldInbut extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final TextInputType textInputType;
  final IconData iconTexfield;
  const TextFieldInbut(
      {Key? key,
      required this.textEditingController,
      this.ispass = false,
      required this.hintText,
      required this.textInputType,
      required this.iconTexfield})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: Icon(iconTexfield)),
      keyboardType: textInputType,
      obscureText: ispass,
    );
  }
}

class TextFieldPost extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final TextEditingController textEditingController;
  const TextFieldPost(
      {Key? key,
      required this.hintText,
      required this.maxLines,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          fillColor: fourdColor,
          filled: true),
      maxLines: maxLines,
    );
  }
}
