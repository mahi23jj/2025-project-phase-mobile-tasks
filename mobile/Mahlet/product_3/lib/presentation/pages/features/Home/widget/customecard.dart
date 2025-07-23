import 'package:flutter/material.dart';
import 'package:product_3/domain/Entity/product_Entity.dart';
import 'package:product_3/core/style.dart';

class Customecard extends StatelessWidget {
  Product cardmodel;
  Customecard({super.key, required this.cardmodel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          // to add image to fit in card
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              cardmodel.imageurl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cardmodel.title, style: AppTextstyle.midtextStyle),
                Text(cardmodel.price, style: AppTextstyle.bodytextStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cardmodel.subtitle, style: AppTextstyle.subtextStyle),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Icon(Icons.star, color: Colors.amber, size: 12),
                //     Text(
                //       '(${cardmodel.rating})',
                //       style: AppTextstyle.subtextStyle,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
