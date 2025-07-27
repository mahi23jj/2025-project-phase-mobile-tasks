import 'package:flutter/material.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/features/product/presentation/pages/features/Home/widget/custome_Icon.dart';
import 'package:product_3/features/product/presentation/pages/features/Home/widget/customecard.dart';
import 'package:product_3/features/product/presentation/pages/features/Search/widget/serach.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/custome_arrow_back.dart';

class Searchpage extends StatelessWidget {
  Searchpage({super.key});

  List<Product> cards = [
    // Cardmodel(
    //   imageurl: 'asset/images/img1.jpg',
    //   price: '\$100',
    //   rating: '4.0',
    //   subtitle: 'Men’s shoe',
    //   title: 'Derby Leather Shoes',
    // ),
    // Cardmodel(
    //   imageurl: 'asset/images/img3.jpg',
    //   price: '\$110',
     
    //   subtitle: 'Womens’s shoe',
    //   title: 'chenoles Hill Shoes',

    // ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomeArrowBack(),
        ),
        title: Text('Search Product',  style: AppTextstyle.submidtextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SearchBox(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Customecard(
                  cardmodel: cards[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
