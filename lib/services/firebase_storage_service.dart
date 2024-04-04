import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<String> uploadProfilePicture(
      {required String filePath, Function(double)? onProgress}) async {
    //completer helps us return either error or success
    Completer<String> completer = Completer<String>();

    try {
      final file = File(filePath);

      // Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();

      // Upload file to the path 'images/mountains.jpg'
      //TODO: change the path to where we want it
      final uploadTask =
          storageRef.child("images/path/to/mountains.jpg").putFile(file);

      // Listen for state changes, errors, and completion of the upload.
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        final progress =
            taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
        if (onProgress != null) {
          onProgress(progress); // Report progress to the caller if provided
        }
      });

      uploadTask.whenComplete(() async {
        try {
          final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
          completer.complete(downloadUrl);
        } catch (error) {
          print("Error getting download URL: $error");
          completer.completeError(error); // Complete with error
        }
      });

      // Monitor upload progress
      monitorUploadProgress(uploadTask);
    } catch (e) {
      print("Error uploading file: $e");
      completer.completeError(e); // Complete with error
    }

    return completer.future;
  }

  void monitorUploadProgress(UploadTask uploadTask) {
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
          print("Upload is ${(progress * 100).toStringAsFixed(2)}% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          print("Upload error:");
          break;
        case TaskState.success:
          print("Upload complete");
          break;
      }
    });
  }
}
