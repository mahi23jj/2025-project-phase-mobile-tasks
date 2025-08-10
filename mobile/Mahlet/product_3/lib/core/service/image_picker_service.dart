// lib/core/services/image_picker_service.dart

import 'dart:io';

abstract class ImagePickerService {
  Future<File?> pickImage();
}
