import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vista/models/profile.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Method to generate a uid
  Future<String> generateUid() async {
    User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      print("User is not logged in");
      throw Exception('User is not logged in');
    }
  }

  // Method to upload profile to firestore
  Future<void> uploadProfile(Profile profile) async {
    try {
      String uid = await generateUid(); // Generate uid
      // Get a reference to the user's document
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Set the profile data as a field in the user's document
      await userDocRef.set(profile.toMap(), SetOptions(merge: true));
      print('Profile uploaded successfully');
    } catch (e) {
      print('Error uploading profile: $e');
    }
  }
}
