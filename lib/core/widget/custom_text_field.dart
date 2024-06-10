// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_smile/core/core.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.title,
    this.icon,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.controller,
    this.onTap,
  });
  final String title;
  final IconData? icon;
  final dynamic validator;
  final bool obscureText;
  var controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: const BoxDecoration(
          color: Color(0xffF1FCFE),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        cursorColor: Palette.primary,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
