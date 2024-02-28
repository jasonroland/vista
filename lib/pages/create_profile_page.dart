import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/models/profile.dart';
import 'package:vista/pages/home_page.dart';
import 'package:vista/services/firebase_firestore_service.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextEditingController = TextEditingController();
    TextEditingController ageTextEditingController = TextEditingController();
    TextEditingController instagramTextEditingController =
        TextEditingController();
    TextEditingController jobOrSchoolTextEditingController =
        TextEditingController();
    String gender = "Male";
    String profileImageLink = "https://example.com/profile.jpg";

    return PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
          // navigationBar: CupertinoNavigationBar(
          //   middle: Text("Create Profile"),
          // ),
          child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Create Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greyNotTransparent,
                  ),
                  width: 240,
                  height: 240,
                  child: Center(
                    child: CupertinoButton(
                        child: Text("Choose Image"), onPressed: () {}),
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: Image.asset(
                //     'lib/assets/bigprofilephoto.png',
                //     width: 240,
                //     height: 240,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(height: 16),
                CupertinoListSection.insetGrouped(
                  children: <CupertinoListTile>[
                    CupertinoListTile(
                      title: Text("Name"),
                      trailing: Expanded(
                        child: CupertinoTextField.borderless(
                            placeholder: "First Name, Last Name",
                            controller: nameTextEditingController),
                      ),
                    ),
                    CupertinoListTile(
                      title: Text("Job/School"),
                      trailing: Expanded(
                        child: CupertinoTextField.borderless(
                            placeholder: "Harvard 2023",
                            controller: jobOrSchoolTextEditingController),
                      ),
                    ),
                    CupertinoListTile(
                      title: Text("Age"),
                      trailing: Expanded(
                        child: CupertinoTextField.borderless(
                          placeholder: "27",
                          controller: ageTextEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                    CupertinoListTile(
                      title: Text("Instagram"),
                      trailing: Expanded(
                        child: CupertinoTextField.borderless(
                          placeholder: "@Yogibear",
                          controller: instagramTextEditingController,
                        ),
                      ),
                    ),
                    CupertinoListTile(
                      title: Text("Sex"),
                      trailing: CupertinoSlidingSegmentedControl<int>(
                        children: {
                          0: Text('Male'),
                          1: Text('Female'),
                        },

                        groupValue: 1,
                        onValueChanged: (int? value) {
                          gender = value == 0 ? "Male" : "Female";
                        }, // Set the default selected index
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CupertinoButton.filled(
                    child: Text(
                      "Save",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onPressed: () async {
                      //creating profile
                      Profile profile = Profile(
                        name: nameTextEditingController.text,
                        jobOrSchool: jobOrSchoolTextEditingController.text,
                        age: int.parse(ageTextEditingController.text),
                        instagram: instagramTextEditingController.text,
                        gender: gender,
                        profileImageLink: profileImageLink,
                      );
                      // upload profile
                      try {
                        await FirebaseFirestoreService().uploadProfile(profile);
                        // Upload successful
                        print('Profile uploaded successfully');
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => HomePage(),
                          ),
                        );
                      } catch (error) {
                        // Error occurred during upload
                        print('Error uploading profile: $error');
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
