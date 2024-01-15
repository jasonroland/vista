import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/game_page.dart';
import 'package:vista/pages/get_to_know_page.dart';

class HowItWorksPage extends ConsumerWidget {
  HowItWorksPage({super.key});

  final availableToMatchSwitchProvider = StateProvider<bool>((ref) {
    return false;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Live match"),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "How it works",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      //child: Padding(
                      // padding: EdgeInsets.all(
                      //      0), //EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                // color:
                                //  CupertinoTheme.of(context).barBackgroundColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //here should be container remove from top
                                  Text(
                                    "Go Live & Match",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: AppColors.whiteTextColor),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Explore and match with live singles.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.greyTextColor),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Capture Personalities", //Explore
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: AppColors.whiteTextColor),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Share your story through 10 image-based prompts in a fun, live, game.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.greyTextColor),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Fast Paced",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: AppColors.whiteTextColor),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Game ends after 10 prompts or 3 minutes whichever comes first",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.greyTextColor),
                                  ),
                                  // SizedBox(
                                  //   height: 24,
                                  // ),
                                  // Text(
                                  //   "Start a Conversation",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w700,
                                  //       fontSize: 20,
                                  //       color: AppColors.whiteTextColor),
                                  // ),
                                  // SizedBox(
                                  //   height: 2,
                                  // ),
                                  // Text(
                                  //   "Begin a conversation by sharing your Instagram after the game.",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 16,
                                  //       color: AppColors.greyTextColor),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          //Spacer(), why cant i use a spacer here??
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoListSection(
                // decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                // color: CupertinoTheme.of(context).barBackgroundColor),
                children: <CupertinoListTile>[
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.circle_fill,
                      color: ref.watch(availableToMatchSwitchProvider)
                          ? AppColors.whiteTextColor
                          : AppColors.darkGreyButtonBackgroundColor,
                    ),
                    title: Text("Go Live"),
                    trailing: CupertinoSwitch(
                        value: ref.watch(availableToMatchSwitchProvider),
                        onChanged: (value) {
                          ref
                              .read(availableToMatchSwitchProvider.notifier)
                              .state = value;
                        }),
                    onTap: () {
                      ref.read(availableToMatchSwitchProvider.notifier).state =
                          !ref
                              .read(availableToMatchSwitchProvider.notifier)
                              .state;
                    },
                  ),
                  if (ref.watch(availableToMatchSwitchProvider)) ...[
                    CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.circle_fill,
                          color: AppColors.blueButtonColor,
                        ),
                        title: Text("Live Singles"), //Find a match
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo: Text("30"),
                        onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) => GetToKnowpage()))),
                    CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.circle_fill,
                          color: AppColors.greenButtonColor,
                        ),
                        title: Text("Instant Matches"),
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo: CircleAvatar(
                          radius: 16,
                          child: Text("2"),
                        ), //Text("2"),
                        onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) => GetToKnowpage()))),
                  ]
                ],
              ),

              // SizedBox(
              //   height: 16,
              // ),

              if (ref.watch(availableToMatchSwitchProvider)) ...[
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "You are now live, feel free to leave the app. You will get a notification when you have a match. ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.greyTextColor),
                  ),
                ),
              ],
              SizedBox(
                height: 32,
              )
            ],
          ),
        ));
  }
}
