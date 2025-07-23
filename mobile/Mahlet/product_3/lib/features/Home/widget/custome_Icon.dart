import 'package:flutter/material.dart';

class CustomeIcon extends StatelessWidget {
  final Icon icon;

  CustomeIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(217, 217, 217, 1), width: 1),
      ),
      child: icon,
    );
  }
}
