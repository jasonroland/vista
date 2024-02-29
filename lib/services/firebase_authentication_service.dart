import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

//service to authenticate users in firebase with phone number (only)
class FirebaseAuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

//step 1, submit phone number which sends code to users phone and get verificationID from firebase
  Future<String> getVerificationID(String userPhoneNumber) async {
    //completer helps pass back data to where it was called from in case of success or error
    Completer<String> verificationCompleter = Completer<String>();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          //right now we are using error.message, this message is not particularly clear to users and might need to break it down and provide a clearer string to user with case/switch
          verificationCompleter.completeError(e.message.toString());
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationCompleter.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto retrieval timeout if needed
        },
      );
    } catch (error) {
      //Handle specific errors
      if (error is FirebaseAuthException) {
        //right now we are using error.message, this message is not particularly clear to users and might need to break it down and provide a clearer string to user with case/switch
        verificationCompleter.completeError(error.message.toString());
      } else {
        verificationCompleter.completeError(error.toString());
      }
    }

    return verificationCompleter.future;
  }

//step 2, submit verificationID (that we got in step 1) & smsCode that was sent to users phone in order to sign user in.
  Future<void> createCredentialAndSignIn(
      String verificationId, String smsCode) async {
    //completer helps pass back data to where it was called from in case of success or error
    Completer<void> signInCompleter = Completer<void>();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      signInCompleter.complete();
    } catch (error) {
      //Handle specific errors
      if (error is FirebaseAuthException) {
        //right now we are using error.message, this message is not particularly clear to users and might need to break it down and provide a clearer string to user with case/switch
        signInCompleter.completeError(error.message.toString());
      } else {
        // Handle generic errors
        print("Error: $error");
        signInCompleter.completeError(error.toString());
      }
    }
    return signInCompleter.future;
  }

//function to sign out user.
  Future<void> signOutUser() async {
    try {
      await auth.signOut();
      print('User signed out successfully');
    } catch (error) {
      print('Error signing out: $error');
      // throw error;
      rethrow; // Re-throw the error to propagate it to the caller
    }
  }
}
