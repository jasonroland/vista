import 'package:flutter/cupertino.dart';

class ErrorCupertinoDialog extends StatelessWidget {
  final String error;

  const ErrorCupertinoDialog({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Oops"),
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
  }
}
