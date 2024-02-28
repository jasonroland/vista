import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/services/login_service.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
//fix the column in this page
  @override
  Widget build(BuildContext context) {
    TextEditingController countryCodeTextEditingController =
        TextEditingController(text: "+1");
    TextEditingController phoneNumberTextEditingController =
        TextEditingController();

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
                      const Row(children: [
                        SizedBox(width: 4),
                        Text("Get Started"),
                        // Spacer()
                      ]),
                      SizedBox(height: 8),
                      CupertinoListSection.insetGrouped(
                        margin: EdgeInsets.all(0),
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 60, // Specify the width here
                                  child: CupertinoTextField.borderless(
                                    keyboardType: TextInputType.phone,
                                    placeholder: "+1",
                                    controller:
                                        countryCodeTextEditingController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[0-9+]')), // Allow digits and "+"
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CupertinoTextField.borderless(
                                  keyboardType: TextInputType.phone,
                                  placeholder: "Enter Phone Number",
                                  controller: phoneNumberTextEditingController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CupertinoButton(
                        child: const Text(
                          "Get Code",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          final phoneNumberToSend =
                              (countryCodeTextEditingController.text +
                                  phoneNumberTextEditingController.text);

                          LoginService loginService = LoginService();
                          // Call getStarted method with the BuildContext and phone number
                          loginService.startLoginProcess(
                              context: context,
                              phoneNumberToSend: phoneNumberToSend);
                        },
                      ),
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
