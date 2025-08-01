import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/features/product/presentation/pages/ProductForm/widget/customeTextForm.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/cusomebutton.dart';
import 'package:product_3/core/widegt/custome_drop_down.dart';
import 'package:product_3/core/widegt/custome_arrow_back.dart';

import '../../../../../../oprations.dart';
import '../../../bloc/product_bloc.dart';
import '../../../bloc/product_event.dart';
import '../../../bloc/product_state.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  String? _category;

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 20);


    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomeArrowBack(
            onTap: () {
              // back to previous page using name route
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('Add Product', style: AppTextstyle.submidtextStyle),
        centerTitle: true,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product Has Not Been Added')),
            );
          } else if (state is ProductCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product added successfully')),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image upload
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text('upload image', style: AppTextstyle.bodytextStyle),
                    ],
                  ),
                ),
              ),

              spacer,
              Text('Name', style: AppTextstyle.bodytextStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameCtrl,
                decoration: fieldDecoration(hint: 'Name'),
              ),

              spacer,
              Text('Price', style: AppTextstyle.bodytextStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: fieldDecoration(
                  hint: 'Price',
                  suffix: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.attach_money, size: 20),
                  ),
                ),
              ),

              spacer,
              Text('Description', style: AppTextstyle.bodytextStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                minLines: 5,
                maxLines: 10,
                decoration: fieldDecoration(hint: 'Description'),
              ),

              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(
                    CreateProductEvent(
                      Product(
                        title: _nameCtrl.text,
                        price: double.parse(_priceCtrl.text),
                        discription: _descCtrl.text,
                        imageurl:
                            '', // Assuming image URL is handled separately
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Cusomebutton(text: 'ADD'),
              ),
              const SizedBox(height: 10),

             
            ],
          ),
        ),
      ),
    );
  }
}
