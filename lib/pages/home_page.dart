import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/edit_profile_page.dart';
import 'package:vista/pages/how_it_works_page.dart';
import 'package:vista/pages/preference_page.dart';
import 'package:vista/pages/welcome_page.dart';
import 'package:vista/services/firebase_authentication_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
        child: Stack(children: [
          CupertinoScrollbar(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                    largeTitle: Text("My Profile"),
                    automaticallyImplyLeading: false,
                    trailing: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        CupertinoIcons.settings_solid,
                        color: AppColors.whiteTextColor,
                      ),
                      onPressed: () {
                        // Add your onPressed logic here
                        _showActionSheet(context);
                      },
                    )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index == 0) {
                      return SizedBox(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 48,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'lib/assets/bigprofilephoto.png',
                                    width: 240,
                                    height: 240,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Larry Burns, 29",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteTextColor),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Manager at EOS systems",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.greyTextColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Instant Message",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      );
                    }
                    //double check spacing here
                    return SizedBox(
                      height: 84,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                      'lib/assets/smallprofilephoto.png',
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Julia",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: AppColors.whiteTextColor),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "@juliaistheone",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: AppColors.greyTextColor),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors
                                          .darkGreyButtonBackgroundColor),
                                  child: const Icon(
                                    CupertinoIcons.pencil,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }, childCount: 6
                      // Change this to the number of containers you want
                      ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: 150.0,
                    //   color: Colors.blueGrey,
                  ),
                ]))
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // height: 200,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.transparent // Colors.black.withOpacity(.3),

                  ///Colors.transparent
                  ),
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 8, bottom: 50),
                  child: MaterialButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => HowItWorksPage()));
                    },
                    color: AppColors.blackTextColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: AppColors.darkGreyTextColor, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Live Match",
                                  style: TextStyle(
                                      color: AppColors.whiteTextColor,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Go live. Match. Capture.", // Match. Capture. Go.
                                  style: TextStyle(
                                      color: AppColors
                                          .whiteNintyPercentTransparent,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(
                              CupertinoIcons.bolt_fill,
                              color: AppColors.yellowButtonColor,
                            )
                          ],
                        ),
                      ),
                    ]),
                  )),
              // child: CupertinoButton(
              //     child: Text("Instant match"), onPressed: () {})),
            ),
          )
        ]),
      ),
    );
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Settings'),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        //  message: const Text('Edit Profile'),
        actions: <CupertinoActionSheetAction>[
          // CupertinoActionSheetAction(
          //   onPressed: () {
          //     Navigator.pop(context);
          //     Navigator.of(context).push(
          //       CupertinoPageRoute(
          //         fullscreenDialog:
          //             false, //not sure which way i want the transitions
          //         builder: (context) => CreateProfilePage(),
          //       ),
          //     );
          //   },
          //   child: const Text('Create Profile'),
          // ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog:
                      false, //not sure which way i want the transitions
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            child: const Text('Edit Profile'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog:
                      false, //not sure which way i want the transitions
                  builder: (context) => PreferencePage(),
                ),
              );
            },
            child: const Text('Preferences'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog:
                      false, //not sure which way i want the transitions
                  builder: (context) => WelcomePage(),
                ),
              );
            },
            child: const Text('welcome'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              FirebaseAuthenticationService().signOutUser().then((_) {
                // Sign out successful, handle any further logic here
                Navigator.pop(context);
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog:
                        false, //not sure which way i want the transitions
                    builder: (context) => WelcomePage(),
                  ),
                );
              }).catchError((error) {
                // Sign out failed, handle the error here
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
            child: const Text('Sign Out'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
