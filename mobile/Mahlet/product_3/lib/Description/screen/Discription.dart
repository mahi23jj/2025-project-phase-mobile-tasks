import 'package:flutter/material.dart';
import 'package:product_3/Description/widget/Custome_size_widget.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/cusomebutton.dart';
import 'package:product_3/core/widegt/custome_arrow_back.dart';

class Discription extends StatelessWidget {
  const Discription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'asset/images/img1.jpg',
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Positioned(
                left: 25,
                top: 20,
                child: CustomeArrowBack()
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Men’s shoe',
                      style: AppTextstyle.subtextStyle.copyWith(fontSize: 14),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        Text(
                          '(4.0)',
                          style: AppTextstyle.subtextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Derby Leather Shoes',
                      style: AppTextstyle.midtextStyle,
                    ),
                    Text('\$100', style: AppTextstyle.bodytextStyle),
                  ],
                ),
                SizedBox(height: 10),
                Text('Size:', style: AppTextstyle.midtextStyle),
                SizedBox(height: 10),
                CustomeSizeWidget(),

                SizedBox(height: 10),

                Text(
                  'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                  style: AppTextstyle.bodytextStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Cusomebutton(
                      text: 'DELETE',
                      backgroundColor: Colors.white,
                      border: Border.all(color: Colors.red),
                      style: AppTextstyle.bodytextStyle.copyWith(
                        color: Colors.red,
                      ),
                      width: 200,
                    ),
                    Cusomebutton(text: 'UPDATE', width: 200),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
