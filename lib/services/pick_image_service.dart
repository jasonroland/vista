import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  Future<String> pickImage() async {
    //this will help us either return the string (imagepath) or error
    Completer<String> completer = Completer<String>();

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        completer.completeError("No image selected.");
        return completer.future;
      }

      final imageTemp = File(image.path);
      completer.complete(imageTemp.path);
    } on PlatformException catch (e) {
      completer.completeError('Failed to pick image: $e');
    }

    return completer.future;
  }
}
