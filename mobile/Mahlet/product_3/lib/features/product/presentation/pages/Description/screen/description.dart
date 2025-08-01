import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/app_route.dart';
import '../../../bloc/product_event.dart';
import '../widget/Custome_size_widget.dart';
import '../../../../../../core/style.dart';
import '../../../../../../core/widegt/cusomebutton.dart';
import '../../../../../../core/widegt/custome_arrow_back.dart';
import '../../../../domain/Entity/product_entity.dart';
import '../../../../../../oprations.dart';

import '../../../bloc/product_bloc.dart';
import '../../../bloc/product_state.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text('Error on display product'));
          } else if (state is SingleProduct) {
            Product Products = state.product;

            return Column(
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
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Products.title,
                            style: AppTextstyle.midtextStyle,
                          ),
                          Text(
                            '$Products.price',
                            style: AppTextstyle.bodytextStyle,
                          ),
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
                              context.read<ProductBloc>().add(
                                DeleteProductEvent(Products.id),
                              );
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
                                arguments: {'Product': Products},
                              );
                            },
                            child: Cusomebutton(text: 'UPDATE', width: 200),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
