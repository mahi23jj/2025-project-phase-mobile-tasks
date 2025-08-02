import 'package:flutter/material.dart';

InputDecoration fieldDecoration({
  required String hint,
  Widget? suffix,
  BorderSide? borderSide,
  Color color = const Color(0xFFF3F3F3),
  // default light gray
}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: color,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: borderSide ?? BorderSide.none,
    ),
    suffixIcon: suffix,
  );
}

