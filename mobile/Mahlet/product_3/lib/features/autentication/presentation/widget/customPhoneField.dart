// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Widget customPhoneField(TextEditingController controller) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.15),
//           blurRadius: 8,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 8),
//     child: InternationalPhoneNumberInput(
//       onInputChanged: (PhoneNumber number) {
//         print('Selected Number: ${number.phoneNumber}');
//       },
//       selectorConfig: const SelectorConfig(
//         selectorType: PhoneInputSelectorType.DROPDOWN, // <-- no bottom sheet
//         leadingPadding: 12,
//         useEmoji: true, // to show the actual flag emoji
//         setSelectorButtonAsPrefixIcon: false,
//       ),
//       initialValue: PhoneNumber(isoCode: 'ET'),
//       selectorTextStyle: const TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       ignoreBlank: false,
//       autoValidateMode: AutovalidateMode.disabled,
//       textFieldController: controller,
//       formatInput: true,
//       keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
//       inputDecoration: const InputDecoration(
//         border: InputBorder.none,
//         hintText: '(+251) 912-34-5678',
//         hintStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//           fontSize: 16,
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//       ),
//       spaceBetweenSelectorAndTextField: 0,
//     ),
//   );
// }
