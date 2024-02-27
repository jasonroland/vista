import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vista/pages/create_profile_page.dart';
import 'package:vista/services/firebase_authentication_service.dart';
import 'package:vista/widgets/error_cupertino_dialog.dart';

class SmsCodeEnterCupertinoDialog extends StatefulWidget {
  final String verificationID;
  final String phoneNumberSent;

  const SmsCodeEnterCupertinoDialog(
      {super.key, required this.verificationID, required this.phoneNumberSent});

  @override
  _SmsCodeEnterCupertinoDialog createState() => _SmsCodeEnterCupertinoDialog(
      verificationID: verificationID, phoneNumberSent: phoneNumberSent);
}

class _SmsCodeEnterCupertinoDialog extends State<SmsCodeEnterCupertinoDialog> {
  final String verificationID;
  final String phoneNumberSent;
  TextEditingController _textFieldController = TextEditingController();

  _SmsCodeEnterCupertinoDialog(
      {required this.verificationID, required this.phoneNumberSent});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Code Sent To\n$phoneNumberSent\n'),
      content: CupertinoTextField(
        controller: _textFieldController,
        placeholder: 'Enter 6 digit code',
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Go Back'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            // Handle submit action
            String enteredText = _textFieldController.text;
            print('Submitted: $enteredText');
            //using a Future.then() .catchError() pattern to manage errors and success
            //creating credential and signing in "step 2"
            FirebaseAuthenticationService()
                .createCredentialAndSignIn(
                    verificationID, _textFieldController.text)
                .then((_) {
              // If sign-in is successful, navigate to the next page
              Navigator.of(context).pop();
              Navigator.of(context).push(
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
          },
          isDefaultAction: true,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
