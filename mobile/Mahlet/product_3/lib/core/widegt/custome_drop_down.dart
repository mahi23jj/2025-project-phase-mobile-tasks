import 'package:flutter/material.dart';
import 'package:product_3/presentation/pages/features/ProductForm/widget/customeTextForm.dart';

class CustomDropdown extends StatelessWidget {
  final void Function(String?) onChanged;
  final String? category;
  final BorderSide? borderSide;
  final Color color;

  const CustomDropdown({
    super.key,
    required this.onChanged,
    this.category,
    this.borderSide,
    this.color = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: category,
      decoration: fieldDecoration(
        hint: 'category',
        color: color,
        borderSide: borderSide,
      ),
      items: const [
        DropdownMenuItem(value: 'Clothing', child: Text('Clothing')),
        DropdownMenuItem(value: 'Men’s shoe', child: Text('Men’s shoe')),
        DropdownMenuItem(value: 'Books', child: Text('Books')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: onChanged,
    );
  }
}
