import 'package:flutter/material.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/cusomebutton.dart';
import 'package:product_3/core/widegt/customeDropDown.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  // show bottom sheet when search icon is pressed
  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        String? selectedValue;
        double price = 50.0;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // wrap content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Text('Categories', style: AppTextstyle.midtextStyle),
                  const SizedBox(height: 10),

                  CustomDropdown(
                    color: Colors.white,
                    borderSide: const BorderSide(color: Colors.black45),
                    category: selectedValue,
                    onChanged: (value) {
                      setModalState(() {
                        selectedValue = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),
                  Text('Price', style: AppTextstyle.midtextStyle),
                  const SizedBox(height: 12),

                  // value label
                  Text(
                    '\$${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Theme.of(context).primaryColor,
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Theme.of(
                        context,
                      ).primaryColor.withOpacity(0.3),
                      overlayColor: Theme.of(context).primaryColor,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                    ),
                    child: Slider(
                      value: price,
                      min: 50.0,
                      max: 200.0,
                      onChanged: (value) {
                        setModalState(() {
                          price = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // button of apply
                 Cusomebutton(
                  text: 'APPLY',
                 )
                ],
              ),
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // TextFormField inside Expanded to take available width
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: "Leather",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Icon button like the image
          GestureDetector(
            onTap: () {
              showFilterBottomSheet(context);
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
           
              child: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
