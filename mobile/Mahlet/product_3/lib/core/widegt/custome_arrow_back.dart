import 'package:flutter/material.dart';

class CustomeArrowBack extends StatelessWidget {
  void Function()? onTap;
   CustomeArrowBack({super.key , this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
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
      ),
    );
  }
}
