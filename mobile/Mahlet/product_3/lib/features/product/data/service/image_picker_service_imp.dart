// lib/features/product/data/services/image_picker_service_impl.dart

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../../core/service/image_picker_service.dart';


class ImagePickerServiceImpl implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
