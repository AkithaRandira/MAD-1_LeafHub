import 'dart:async';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.Controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: Controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x10DA24))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400),
            ),
            fillColor: Color(0xFFCFEED8),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
