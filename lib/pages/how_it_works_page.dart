import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/live_singles_new_page.dart';

class HowItWorksPage extends ConsumerWidget {
  HowItWorksPage({super.key});

  final availableToMatchSwitchProvider = StateProvider<bool>((ref) {
    return false;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("How it works"),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                          0), //EdgeInsets.only(left: 16, right: 16),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Icon(CupertinoIcons.globe),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Live Singles", // "Go Live & Match",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.whiteTextColor),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Explore and match with live singles.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color:
                                                      AppColors.greyTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.camera_circle_fill),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Capture Personalities", //Explore
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .whiteTextColor),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "Share your story through 10 image-based prompts in a fun, live, game.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: AppColors
                                                        .greyTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons
                                            .hourglass_tophalf_fill),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Fast Paced",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .whiteTextColor),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "Game ends after 10 prompts or 3 minutes whichever comes first",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: AppColors
                                                        .greyTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24,
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
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoListSection.insetGrouped(
                margin: const EdgeInsets.all(16),
                children: <CupertinoListTile>[
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.circle_fill,
                      color: ref.watch(availableToMatchSwitchProvider)
                          ? CupertinoColors.activeGreen
                          : AppColors.whiteTextColor,
                    ),
                    title: const Text("Go Live"),
                    trailing: CupertinoSwitch(
                        value: ref.watch(availableToMatchSwitchProvider),
                        onChanged: (value) {
                          ref
                              .read(availableToMatchSwitchProvider.notifier)
                              .state = value;
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPopupSurface(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 32, top: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Container(
                                          //   //  width: 300,
                                          //   height: 12,
                                          //   // child: LinearProgressIndicator(
                                          //   //   backgroundColor:
                                          //   //       AppColors.whiteTextColor,
                                          //   //   color: AppColors.yellowButtonColor,
                                          //   //   borderRadius:
                                          //   //       BorderRadius.circular(8),
                                          //   // ),
                                          // ),
                                          // ElevatedButton(
                                          //   child: const Text('Close BottomSheet'),
                                          //   onPressed: () => Navigator.pop(context),
                                          // ),

                                          const Text(
                                            "You are now live",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color:
                                                    AppColors.whiteTextColor),
                                          ),
                                          const SizedBox(height: 16),

                                          CupertinoButton.filled(
                                              //   padding: EdgeInsets.all(16),
                                              child: const Column(
                                                children: [
                                                  Icon(CupertinoIcons.globe),
                                                  SizedBox(height: 4),
                                                  Text("320 Live Singles"),
                                                ],
                                              ),
                                              onPressed: () =>
                                                  Navigator.of(context).push(
                                                    CupertinoPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) =>
                                                          const LiveSinglesNewPage(),
                                                    ),
                                                  )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                    onTap: () {
                      // ref.read(availableToMatchSwitchProvider.notifier).state =
                      //     !ref
                      //         .read(availableToMatchSwitchProvider.notifier)
                      //         .state;
                      // Navigator.of(context).push(CupertinoPageRoute(
                      //   fullscreenDialog: true,
                      //   builder: (context) => LiveSinglesNewPage(),
                      // ));
                    },
                  ),
                  // if (ref.watch(availableToMatchSwitchProvider)) ...[
                  //   CupertinoListTile(
                  //       leading: const Icon(
                  //         CupertinoIcons.circle_fill,
                  //         color: AppColors.blueButtonColor,
                  //       ),
                  //       title: const Text("Live Singles"), //Find a match
                  //       trailing: const CupertinoListTileChevron(),
                  //       additionalInfo: Text("30"),
                  //       onTap: () => Navigator.of(context).push(
                  //           CupertinoPageRoute(
                  //               builder: (context) =>
                  //                   const LiveSinglesPage()))),
                  //   CupertinoListTile(
                  //       leading: const Icon(
                  //         CupertinoIcons.circle_fill,
                  //         color:
                  //             AppColors.yellowButtonColor, //greenButtonColor,
                  //       ),
                  //       title: const Text("Instant Matches"),
                  //       trailing: const CupertinoListTileChevron(),
                  //       additionalInfo: const CircleAvatar(
                  //         backgroundColor: AppColors.yellowButtonColor,
                  //         radius: 16,
                  //         child: Text("2",
                  //             style: TextStyle(
                  //                 color: AppColors.darkGreyTextColor)),
                  //       ), //Text("2"),
                  //       onTap: () => Navigator.of(context).push(
                  //           CupertinoPageRoute(
                  //               builder: (context) =>
                  //                   const InstantMatchPage()))),
                  // ]
                ],
              ),

              // SizedBox(
              //   height: 16,
              // ),

              //  if (ref.watch(availableToMatchSwitchProvider)) ...[
              // const Padding(
              //   padding: EdgeInsets.only(left: 16, right: 16),
              //   child: Text(
              //     "You are now live, feel free to leave the app. You will get a notification when you have a match.",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w500,
              //         fontSize: 16,
              //         color: AppColors.greyTextColor),
              //   ),
              // ),
              //  ],
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ));
  }
}
