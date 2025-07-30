import 'package:flutter/material.dart';
import 'package:product_3/core/app_route.dart';
import 'package:product_3/features/product/presentation/pages/Description/widget/Custome_size_widget.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/cusomebutton.dart';
import 'package:product_3/core/widegt/custome_arrow_back.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/oprations.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {


  late  Oprations oprations;
  late   Product card;

@override
void didChangeDependencies() {
   final args = ModalRoute.of(context)!.settings.arguments as Map;
    card = args["card"];
     oprations = args["operations"];
  }

  @override
  Widget build(BuildContext context) {
   

      final Product Products =
      oprations.Cards.firstWhere((c) => c.id == card.id);

    return Scaffold(
      
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  Products.imageurl,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Positioned(
                left: 25,
                top: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CustomeArrowBack(),
                ),
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
                      Products.subtitle,
                      style: AppTextstyle.subtextStyle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Products.title, style: AppTextstyle.midtextStyle),
                    Text('$Products.price' , style: AppTextstyle.bodytextStyle),
                  ],
                ),
                SizedBox(height: 10),
                Text('Size:', style: AppTextstyle.midtextStyle),
                SizedBox(height: 10),
                CustomeSizeWidget(),

                SizedBox(height: 10),

                Text(
                  Products.discription,
                  style: AppTextstyle.bodytextStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          oprations.removeFromCart(Products.id);
                        });
                        Navigator.pop(context);
                      },
                      child: Cusomebutton(
                        text: 'DELETE',
                        backgroundColor: Colors.white,
                        border: Border.all(color: Colors.red),
                        style: AppTextstyle.bodytextStyle.copyWith(
                          color: Colors.red,
                        ),
                        width: 200,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.edit,
                          arguments: {
                            "card": Product,
                            "operations": oprations,
                          },
                        ).then((_) {
                          setState(() {});
                        });
                      },
                      child: Cusomebutton(text: 'UPDATE', width: 200),
                    ),
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
