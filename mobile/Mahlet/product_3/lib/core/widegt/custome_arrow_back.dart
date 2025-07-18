import 'package:flutter/material.dart';

class CustomeArrowBack extends StatelessWidget {
  const CustomeArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20, // Adjust size
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Icon(
          weight: 20,
          Icons.arrow_back_ios,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
