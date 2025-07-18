import 'package:flutter/material.dart';
import 'package:product_3/Home/data/cardmodel.dart';
import 'package:product_3/Home/widget/custome_Icon.dart';
import 'package:product_3/Home/widget/customecard.dart';
import 'package:product_3/core/style.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  List<Cardmodel> Cards = [
    Cardmodel(
      imageurl: 'asset/images/img1.jpg',
      price: '\$100',
      rating: '4.0',
      subtitle: 'Men’s shoe',
      title: 'Derby Leather Shoes',
    ),
    Cardmodel(
      imageurl: 'asset/images/img3.jpg',
      price: '\$110',
      rating: '4.5',
      subtitle: 'Womens’s shoe',
      title: 'chenoles Hill Shoes',
    ),
    Cardmodel(
      imageurl: 'asset/images/img2.jpg',
      price: '\$200',
      rating: '2.5',
      subtitle: 'Children’s shoe',
      title: 'FAN KA HAO Shoes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.asset(
              'asset/images/profile.jpg',
              width: 65,
              height: 65,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('July 14.2025', style: AppTextstyle.subtextStyle),
            SizedBox(height: 4),
            //Text.rich
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: AppTextstyle.submidtextStyle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Sara',
                    style: AppTextstyle.submidtextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomeIcon(
              icon: Icon(Icons.notification_add_rounded, color: Colors.black),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available Products', style: AppTextstyle.titleStyle),
                CustomeIcon(icon: Icon(Icons.search, color: Colors.grey)),
              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Cards.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Customecard(cardmodel: Cards[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
