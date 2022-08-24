import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  TextEditingController? controller;
  String? initialValue;
  final String textLabel;
  final bool isPassword;
  final Function validate;
  final VoidCallback? suffixPressed;
  final VoidCallback? onTap;
  IconButton? iconData;
  final Function? onSubmit;
  final TextInputType type;
  final bool inRating;
  final Function onChange;

  ReusableTextField({
    required this.controller,
    this.isPassword = false,
    required this.textLabel,
    required this.validate,
    this.suffixPressed,
    this.onTap,
    this.iconData,
    required this.type,
    this.onSubmit,
    this.inRating = false,
    required this.onChange,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      keyboardType: type,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        // labelText: textLabel,
        // labelStyle: const TextStyle(
        //   color: Colors.black87,
        //   fontSize: 12,
        // ),

        hintText: textLabel,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),

        suffixIcon: inRating ? iconData : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        fillColor: Colors.deepOrangeAccent,
        filled: true,
      ),
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (val) => onSubmit!(val),
      validator: (val) => validate(val),
      onChanged: (val) => onChange(val),
    );
  }
}
