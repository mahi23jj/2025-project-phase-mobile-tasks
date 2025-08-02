import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/core/style.dart';
import 'package:product_3/core/widegt/cusomebutton.dart';
import 'package:product_3/core/widegt/custome_arrow_back.dart';
import '../../../bloc/product_bloc.dart';
import '../../../bloc/product_event.dart';
import '../../../bloc/product_state.dart';
import '../widget/customeTextForm.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacer = const SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomeArrowBack(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text('Add Product', style: AppTextstyle.submidtextStyle),
        centerTitle: true,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product Has Not Been Added')),
            );
          } else if (state is ProductCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: _selectedImage == null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_outlined,
                                size: 40, color: Colors.grey.shade600),
                            const SizedBox(height: 8),
                            Text('Upload Image',
                                style: AppTextstyle.bodytextStyle),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                ),
              ),

              spacer,
              Text('Name', style: AppTextstyle.bodytextStyle),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('product_name'),
                controller: _nameCtrl,
                decoration: fieldDecoration(hint: 'Name'),
              ),

              spacer,
              Text('Price', style: AppTextstyle.bodytextStyle),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('product_price'),
                controller: _priceCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                key: const Key('product_description'),
                controller: _descCtrl,
                minLines: 5,
                maxLines: 10,
                decoration: fieldDecoration(hint: 'Description'),
              ),

              const SizedBox(height: 32),
              GestureDetector(
                key: const Key('product_Add'),
                onTap: () {
                  if (_selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please upload an image')),
                    );
                    return;
                  }

                  context.read<ProductBloc>().add(
                        CreateProductEvent(
                          Product(
                            title: _nameCtrl.text,
                            price: double.tryParse(_priceCtrl.text) ?? 0,
                            discription: _descCtrl.text,
                            imageurl: _selectedImage!.path, // local image path
                          ),
                        ),
                      );
                },
                child: Cusomebutton(text: 'ADD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
