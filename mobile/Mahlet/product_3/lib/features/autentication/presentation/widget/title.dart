import 'package:flutter/material.dart';

Widget Titles({
 String? text,
  String? boldtext,
  TextAlign align = TextAlign.start,
  TextStyle? style,
}) {
  return 
  
  
  
  
  Builder(
    builder: (context) {
      final theme = Theme.of(context).textTheme;

      return RichText(
        text: TextSpan(
          text: text ?? '',
          style:
              style ??
              theme.headlineSmall?.copyWith(
                fontSize: 16,
                letterSpacing: 0.5,
                color: Colors.black54,
              ),
          children: <TextSpan>[
            TextSpan(
              text: boldtext,
              style: style
            ),
          ],
        ),
        textAlign: align,
      );
    },
  );
}