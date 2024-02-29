import 'package:flutter/cupertino.dart';

class ErrorCupertinoDialog extends StatelessWidget {
  final String error;

  const ErrorCupertinoDialog({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Oops"),
      content: Text(error),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
