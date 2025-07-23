import 'package:flutter/material.dart';
import 'package:product_3/domain/Entity/product_entity.dart';
import 'package:product_3/presentation/pages/features/Home/widget/custome_Icon.dart';
import 'package:product_3/presentation/pages/features/Home/widget/customecard.dart';
import 'package:product_3/core/app_route.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/oprations.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Oprations oprations = Oprations();

  @override
  Widget build(BuildContext context) {
    var cards = oprations.Cards;
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
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoute.productForm,
            arguments: oprations,
          ).then((_) {
            setState(() {});
          });
        },
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
              itemCount: oprations.Cards.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.productDetail,
                      arguments: {
                        "card": oprations.Cards[index],
                        "operations": oprations,
                      },
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  child: Customecard(cardmodel: oprations.Cards[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
