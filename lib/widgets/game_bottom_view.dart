import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/pages/game_over_page.dart';
import 'package:vista/pages/game_page.dart';
import 'package:vista/widgets/camera.dart';

class GameBottomView extends ConsumerWidget {
  final GameViewBottomViewEnum bottomViewType;
  const GameBottomView({super.key, required this.bottomViewType});

  String imageCapturedFilePath(String filepath) {
    return "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (BuildContext context) {
        if (bottomViewType == GameViewBottomViewEnum.waiting) {
          return _buildWaitingView(context, ref);
        } else if (bottomViewType == GameViewBottomViewEnum.gameOver) {
          return _buildGameOverView(context, ref);
        } else if (bottomViewType == GameViewBottomViewEnum.explain) {
          return _buildExplainView(context, ref);
        } else if (bottomViewType == GameViewBottomViewEnum.camera) {
          return _buildCameraView(context, ref);
        }
        return const Text("Error: Specify enum type");
      },
    );
  }

  Widget _buildWaitingView(BuildContext context, WidgetRef ref) {
    //waiting view
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: CupertinoTheme.of(context).barBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                    child: Text(
                      "Waiting for Jules",
                      style: TextStyle(color: AppColors.greyTextColor),
                    ),
                    onPressed: () {
                      ref.read(gameBottomViewController.notifier).state =
                          GameViewBottomViewEnum.gameOver;
                    })
                // children: [
                //   Text(
                //     "Waiting for Jules",
                //     style: TextStyle(color: AppColors.greyTextColor),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverView(BuildContext context, WidgetRef ref) {
    //game over view
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: CupertinoTheme.of(context).barBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                    child: const Text(
                      "Game over",
                      style: TextStyle(color: AppColors.whiteTextColor),
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => GameOverPage()));

                      ref.read(gameBottomViewController.notifier).state =
                          GameViewBottomViewEnum.explain;
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExplainView(BuildContext context, WidgetRef ref) {
    //explain view
    return Container(
      color: CupertinoTheme.of(context).barBackgroundColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uncover Personality",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.whiteTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Show a window into your life by\nanswering prompts with an\nhonest image",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.greyTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            CupertinoButton.filled(
                child: Text(
                  "Lets go!",
                  style: TextStyle(
                    color: AppColors.whiteTextColor,
                  ),
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  ref.read(gameBottomViewController.notifier).state =
                      GameViewBottomViewEnum.camera;
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraView(BuildContext context, WidgetRef ref) {
    //camera view
    return Container(
        //     .width, //MediaQuery.sizeOf(context).height, this is interesting as the image has to be a square so if there isnt enough hight image will start to show some "padding"
        height:
            508, //TODO: fix this layout, right now relying on manual hight which will cause issues in different screensizes because the preview is dynamic based on exact mediaquery size
        color: CupertinoTheme.of(context).barBackgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prompt:",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 56),
                            child: Text(
                              "Show your most recent vacation",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.whiteTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    CupertinoButton(
                        child: Text("Library",
                            style: TextStyle(color: AppColors.greyTextColor)),
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                //checking if an image has been captured
                if (ref.watch(isImageCapturedProvider)) {
                  print("Image captured so we showing this view");
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 1 / 1,
                                  child: Center(
                                    child: Image(
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width,
                                      image: FileImage(File(imagePath)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CupertinoButton.filled(
                            child: Text(
                              "Send",
                              style: TextStyle(color: AppColors.whiteTextColor),
                            ),
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              ref
                                  .read(gameBottomViewController.notifier)
                                  .state = GameViewBottomViewEnum.waiting;
                              ref.read(isImageCapturedProvider.notifier).state =
                                  false;
                              //over here we are using this key to dispose the controller because since we are displaying and undisplaying it without using a navigator the dispose never gets called unless we do it
                              takePictureScreenKey.currentState
                                  ?.disposeController();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Create a new instance of TakePictureScreen within the Consumer
                  print("yeah we here but weird shii");
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: TakePictureScreen(
                      key: takePictureScreenKey,
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
