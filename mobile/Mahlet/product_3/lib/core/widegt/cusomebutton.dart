import 'package:flutter/material.dart';

class Cusomebutton extends StatelessWidget {
  final double? width;
  final Color? backgroundColor;
  final BoxBorder? border;
  final String text;
  final TextStyle? style;
  Cusomebutton({
    super.key,
    this.backgroundColor,
    this.width,
    this.border,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
        border: border ?? Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Text(
        text,
        style: style ?? TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
