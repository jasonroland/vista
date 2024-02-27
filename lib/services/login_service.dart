import 'package:flutter/cupertino.dart';
import 'package:vista/services/firebase_authentication_service.dart';
import 'package:vista/widgets/error_cupertino_dialog.dart';
import 'package:vista/widgets/sms_code_enter_cupertino_dialog.dart';

//this class is called from the welcome page ui signs user in (using the FirebaseAuthenticationService) and shows dialog if there are errors
class LoginService {
  void startLoginProcess(BuildContext context, String phoneNumberToSend) {
    FirebaseAuthenticationService authService = FirebaseAuthenticationService();

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
}
