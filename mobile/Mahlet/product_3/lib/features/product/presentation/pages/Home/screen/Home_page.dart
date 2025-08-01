import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/features/product/presentation/pages/Home/widget/custome_Icon.dart';
import 'package:product_3/features/product/presentation/pages/Home/widget/customecard.dart';
import 'package:product_3/core/app_route.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/oprations.dart';

import '../../../bloc/product_bloc.dart';
import '../../../bloc/product_event.dart';
import '../../../bloc/product_state.dart';

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

            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text('Error loading products'));
                } else if (state is ProductLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ProductBloc>().add(
                            GetSingleProductEvent(state.products[index].id),
                          );
                          Navigator.pushNamed(context, AppRoute.productDetail,
                          
                         
                          ) ;
                        },
                        child: Customecard(cardmodel: state.products[index]),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
