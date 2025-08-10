import 'package:flutter/material.dart';




Widget customButton({required Function() onTap, required String text,required Color color , required TextStyle style}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
// ?? 
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20,),
          alignment: Alignment.center,
          height:60 ,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color ,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text , style:style ,),
        ),
      );
    },
  );
}