// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatefulWidget {
//   void Function(String)? onChanged;
//   final String hintText;
//   final TextEditingController controller;
//   final Icon? prefixIcon;
//   final TextInputType keyboardType;
//   final bool isPassword;
//    // optional external toggle

//    CustomTextFormField({
//     Key? key,
   
//     required this.hintText,
//     required this.controller,
//     this.prefixIcon,
//     required this.keyboardType,
//     this.isPassword = false,
//     this.onChanged,
   
//   }) : super(key: key);

//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   bool _obscure = true;



//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final inputTheme = theme.inputDecorationTheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Text(widget.labelText, style: theme.textTheme.bodyMedium),
//         // const SizedBox(height: 7),
//         TextFormField(
//           // background of white
          
//           onChanged:  widget.onChanged ?? (null),
//           controller: widget.controller,
//           keyboardType: widget.keyboardType,
//           obscureText: widget.isPassword ? _obscure : false,
//           decoration: InputDecoration(
            
//             hintText: widget.hintText,
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(
//                 left: 16,
//                 right: 8,
//               ), // Padding before icon
//               child: widget.prefixIcon,
//             ),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     icon: Icon(
//                       _obscure
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined,
//                       color: Colors.grey,
                       
//                     ),
//                     onPressed: () => setState(() => _obscure = !_obscure),
//                   )
//                 : null,

//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Color.fromARGB(255, 211, 210, 210),
//                 width: 1.5,
//               ),
//             ),
//             contentPadding: inputTheme.contentPadding,
//             focusedBorder: inputTheme.focusedBorder,
//             hintStyle: inputTheme.hintStyle,
//             prefixIconColor: inputTheme.prefixIconColor,
//             suffixIconColor: inputTheme.suffixIconColor,
//             prefixIconConstraints: inputTheme.prefixIconConstraints,
//             suffixIconConstraints: inputTheme.suffixIconConstraints,
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'This field is required';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final TextInputType keyboardType;
  final bool isPassword;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    required this.keyboardType,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscure : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // White background like screenshot
        hintText: widget.hintText,
        hintStyle: inputTheme.hintStyle,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: widget.prefixIcon,
              )
            : null,
        prefixIconConstraints: inputTheme.prefixIconConstraints,
        suffixIconConstraints: inputTheme.suffixIconConstraints,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        contentPadding: inputTheme.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        focusedBorder: inputTheme.focusedBorder,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
