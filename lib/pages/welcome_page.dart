import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/services/authentication_service.dart';
import 'package:vista/widgets/phone_code_alert.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
//fix the column in this page
  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      child: CupertinoPageScaffold(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vista.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: AppColors.whiteTextColor.withOpacity(.9)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Let's Break the Ice",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: AppColors.whiteTextColor.withOpacity(.8)),
                      ),
                    ],
                  ),
                  SizedBox(height: 64),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'lib/assets/elephant.png',
                      // width: 240,
                      //  height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 32),
                  Column(
                    children: [
                      Row(children: [
                        SizedBox(width: 4),
                        Text("Get Started"),
                        // Spacer()
                      ]),
                      SizedBox(height: 8),
                      CupertinoListSection.insetGrouped(
                        margin: EdgeInsets.all(0),
                        children: const <CupertinoListTile>[
                          CupertinoListTile(
                            title: CupertinoTextField.borderless(
                              keyboardType: TextInputType.phone,
                              placeholder: "Enter Phone Number",
                              // controller: TextEditingController(text: "+1"),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 16),
                      CupertinoButton(
                          child: const Text(
                            "Get Code",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            //using a Future.then() .catchError() pattern to manage errors and success
                            // Call the authentication service to get the verification ID "step 1"
                            AuthenticationService()
                                .getVerificationID("+18888888888")
                                .then((verificationID) {
                              //success
                              // Verification code received successfully
                              print(
                                  'Verification ID received: $verificationID');
                              // Show a dialog to enter the verification code
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => PhoneCodeAlert(
                                    verificationID: verificationID),
                              );
                            }).catchError((error) {
                              // Error occurred during verification process
                              print('Error during verification: $error');
                              // Handle the error, by showing dialog to user
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
                          }),
                      const SizedBox(height: 16),
                    ],
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
