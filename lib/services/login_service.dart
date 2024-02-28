import 'package:flutter/cupertino.dart';
import 'package:vista/pages/create_profile_page.dart';
import 'package:vista/pages/welcome_page.dart';
import 'package:vista/services/firebase_authentication_service.dart';
import 'package:vista/widgets/error_cupertino_dialog.dart';
import 'package:vista/widgets/sms_code_enter_cupertino_dialog.dart';

//this class signs user in (using the FirebaseAuthenticationService) and shows dialog if there are errors
class LoginService {
  FirebaseAuthenticationService authService = FirebaseAuthenticationService();
//shows cupertio dialog if failed
  void startLoginProcess(
      {required BuildContext context, required String phoneNumberToSend}) {
    if (phoneNumberToSend.length < 10) {
      showCupertinoDialog(
        context: context,
        builder: (context) => const ErrorCupertinoDialog(
            error:
                "Phone number is invalid, please check phone number and country code and try again"),
      );
    } else {
      // Call the authentication service to get the verification ID "step 1"
      authService.getVerificationID(phoneNumberToSend).then((verificationID) {
        // Verification code received successfully
        print('Verification ID received: $verificationID');
        // Show a dialog to enter the verification code
        showCupertinoDialog(
          context: context,
          builder: (context) => SmsCodeEnterCupertinoDialog(
            verificationID: verificationID,
            phoneNumberSent: phoneNumberToSend,
          ),
        );
      }).catchError((error) {
        // Handle the error, by showing dialog to user
        print('Error during verification: $error');
        showCupertinoDialog(
          context: context,
          builder: (context) => ErrorCupertinoDialog(error: error.toString()),
        );
      });
    }
  }

//shows cupertio dialog if logingin failed
  void finishLoginProcess({
    required BuildContext context,
    required String verificationID,
    required String smsCode,
  }) {
    // FirebaseAuthenticationService()
    authService.createCredentialAndSignIn(verificationID, smsCode).then((_) {
      // If sign-in is successful, navigate to the next page
      Navigator.of(context).pop();
      Navigator.of(context).push(
        //TODO: if user already has a profile, when sign in take him to the home page (can use a ternary operator)
        CupertinoPageRoute(
          fullscreenDialog: false,
          builder: (context) => const CreateProfilePage(),
        ),
      );
    }).catchError((error) {
      // If there's an error during sign-in, handle it here
      print('Error during verification: $error');
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return ErrorCupertinoDialog(error: error.toString());
        },
      );
    });
  }

//shows cupertio dialog if signout failed
  void signUserOut({required BuildContext context}) {
    authService
        .signOutUser()
        .then((_) => Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog:
                    false, //not sure which way i want the transitions
                builder: (context) => WelcomePage(),
              ),
            ))
        .catchError((error) => showCupertinoDialog(
              context: context,
              builder: (context) {
                return ErrorCupertinoDialog(error: error.toString());
              },
            ));
  }
}
