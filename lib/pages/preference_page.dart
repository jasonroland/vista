import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Preferences"),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
                      CupertinoListTile(
                        title: Text("Name"),
                        trailing: Expanded(
                          child: CupertinoTextField.borderless(
                            placeholder: "First Name, Last Name",
                            // controller:
                            //     TextEditingController(text: "First Name"),
                          ),
                        ),
                      ),
                      CupertinoListTile(
                        title: Text("Job/School"),
                        trailing: Expanded(
                          child: CupertinoTextField.borderless(
                            placeholder: "Harvard 2023",
                            // controller:
                            //     TextEditingController(text: "First Name"),
                          ),
                        ),
                      ),
                      CupertinoListTile(
                        title: Text("Age"),
                        trailing: Expanded(
                          child: CupertinoTextField.borderless(
                            placeholder: "27",
                            // controller:
                            //     TextEditingController(text: "First Name"),
                          ),
                        ),
                      ),
                      CupertinoListTile(
                        title: Text("Instagram"),
                        trailing: Expanded(
                          child: CupertinoTextField.borderless(
                            placeholder: "@Yogibear",
                            // controller:
                            //     TextEditingController(text: "First Name"),
                          ),
                        ),
                      ),
                      CupertinoListTile(
                        title: Text("Distance"),
                        trailing: CupertinoSlidingSegmentedControl<int>(
                          children: {
                            0: Text('25 Miles'),
                            1: Text('75 Miles'),
                            3: Text('Worldwide'),
                          },

                          groupValue: 1,
                          onValueChanged:
                              (int? value) {}, // Set the default selected index
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  CupertinoButton.filled(child: Text("Save"), onPressed: () {})
                ],
              ),
            ),
          ),
        ));
  }
}
