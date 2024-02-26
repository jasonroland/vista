import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Edit Profile"),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Larry Burns, 29",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteTextColor),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'lib/assets/bigprofilephoto.png',
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  //16 px space around cupertinobutton by default
                  CupertinoButton(
                      child: Text("Replace Image"), onPressed: () {}),
                  SizedBox(height: 16),
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
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
                        title: Text("Instagram"),
                        trailing: Expanded(
                          child: CupertinoTextField.borderless(
                            placeholder: "@Yogibear",
                            // controller:
                            //     TextEditingController(text: "First Name"),
                          ),
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
