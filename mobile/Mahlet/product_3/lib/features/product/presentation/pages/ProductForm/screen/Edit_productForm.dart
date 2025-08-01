import 'package:flutter/material.dart';


import '../../../../../../core/style.dart';
import '../../../../../../core/widegt/cusomebutton.dart';
import '../../../../../../core/widegt/custome_drop_down.dart';
import '../../../../../../core/widegt/custome_arrow_back.dart';
import '../../../../../../oprations.dart';
import '../../../../domain/Entity/product_entity.dart';
import '../widget/customeTextForm.dart';

class EditFormpage extends StatefulWidget {
  const EditFormpage({super.key});

  @override
  State<EditFormpage> createState() => _EditFormpageState();
}

class _EditFormpageState extends State<EditFormpage> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  String? _category;

  late Product cardmodel;
  late Oprations operations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    cardmodel = args["card"];
    operations = args["operations"];

    _nameCtrl.text = cardmodel.title;
    _priceCtrl.text = cardmodel.price.toString();
    //cardmodel.price as double.toString();
    _descCtrl.text = cardmodel.discription;
  }

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
        title: Text('Edit Product', style: AppTextstyle.submidtextStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            Text('category', style: AppTextstyle.bodytextStyle),
            const SizedBox(height: 8),

            CustomDropdown(
              onChanged: (value) => setState(() => _category = value),
              category: _category,
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
                operations.editproduct(
                  cardmodel.id,
                  Product(
                    id: cardmodel.id,
                    imageurl: 'asset/images/img1.jpg',
                    title: _nameCtrl.text,
                    price: _priceCtrl.text as double,
                    discription: _descCtrl.text,
                  ),
                );
                // Navigator.pushNamed(context, AppRoute.home);
                Navigator.pop(context); // go back after adding
              },
              child: Cusomebutton(text: 'Edit'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
