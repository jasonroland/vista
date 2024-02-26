import 'package:flutter/cupertino.dart';
import 'package:vista/pages/create_profile_page.dart';
import 'package:vista/services/authentication_service.dart';

class PhoneCodeAlert extends StatefulWidget {
  final String verificationID;

  const PhoneCodeAlert({super.key, required this.verificationID});

  @override
  _PhoneCodeAlertState createState() =>
      _PhoneCodeAlertState(verificationID: verificationID);
}

class _PhoneCodeAlertState extends State<PhoneCodeAlert> {
  final String verificationID;
  TextEditingController _textFieldController = TextEditingController();

  _PhoneCodeAlertState({required this.verificationID});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Code Sent To\n+1 875-987-2343\n'),
      content: CupertinoTextField(
        controller: _textFieldController,
        placeholder: 'Enter 6 digit code',
        keyboardType: TextInputType.number,
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
            AuthenticationService()
                .createCredentialAndSignIn(
                    verificationID, _textFieldController.text)
                .then((_) {
              // If sign-in is successful, navigate to the next page
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => CreateProfilePage(),
                ),
              );
            }).catchError((error) {
              // If there's an error during sign-in, handle it here
              print('Error during verification: $error');
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Oops'),
                    content: Text(error),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
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
