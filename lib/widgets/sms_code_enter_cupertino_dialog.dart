import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vista/services/login_service.dart';

class SmsCodeEnterCupertinoDialog extends StatelessWidget {
  final String verificationID;
  final String phoneNumberSent;
  final TextEditingController _textFieldController = TextEditingController();

//constructor
  SmsCodeEnterCupertinoDialog({
    required this.verificationID,
    required this.phoneNumberSent,
    Key? key,
  }) : super(key: key);

//function to handle the submition when user enters the code.
  void handleSubmit(BuildContext context) {
    String enteredText = _textFieldController.text;
    print('Submitted: $enteredText');
    // Creating credential and signing in "step 2"
    LoginService().finishLoginProcess(
      context: context,
      verificationID: verificationID,
      smsCode: enteredText,
    );
  }

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
            handleSubmit(context);
          },
          isDefaultAction: true,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
