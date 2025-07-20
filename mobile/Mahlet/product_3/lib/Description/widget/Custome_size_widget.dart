import 'package:flutter/material.dart';
import 'package:product_3/core/style.dart';

class CustomeSizeWidget extends StatefulWidget {
  const CustomeSizeWidget({super.key});

  @override
  State<CustomeSizeWidget> createState() => _CustomeSizeWidgetState();
}

class _CustomeSizeWidgetState extends State<CustomeSizeWidget> {


  int isselected = 0;

  List<String> size = ['39', '40', '41', '42', '43', '44', '45'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: customeSizeWidget(size[index], index),
          );
        }),
      ),
    );
  }

  Widget customeSizeWidget(String text, int idx) {
    bool isactive = idx == isselected;
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isselected = idx;
            });
          },
          child: Container(
            alignment: Alignment.center,
            width: 70,
            height: 50,
            decoration: BoxDecoration(
              color: isactive ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: isactive
                  ? AppTextstyle.midtextStyle.copyWith(color: Colors.white)
                  : AppTextstyle.midtextStyle,
            ),
          ),
        );
      },
    );
  }
}
