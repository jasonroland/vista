import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/pages/game_page.dart';
import 'package:vista/widgets/camera.dart';

//TODO: this page should be depreciated
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
        if (bottomViewType == GameViewBottomViewEnum.explain) {
          return _buildExplainView(context, ref);
        } else if (bottomViewType == GameViewBottomViewEnum.camera) {
          return buildCameraView(context, ref);
        }
        return const Text("Error: Specify enum type");
      },
    );
  }

  Widget _buildExplainView(BuildContext context, WidgetRef ref) {
    return CupertinoPopupSurface(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Row(
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
                child: const Text(
                    "Lets go!"), //maybe needs to be a bit bolder, idk
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
}

Widget buildCameraView(BuildContext context, WidgetRef ref) {
  //camera view
  return CupertinoPopupSurface(
    child: Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
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
                        child: const Text(
                          "What inspired your recently?",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.whiteTextColor,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const Icon(CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: AppColors.greyTextColor),
                CupertinoButton(
                    padding: const EdgeInsets.only(
                        left: 8, right: 16, top: 16, bottom: 16),
                    child: const Text("Photo Library",
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
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
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
                  Positioned(
                      right: 20,
                      top: 20,
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.xmark,
                          color: AppColors.blueButtonColor,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              AppColors.whiteTextColor),
                        ),
                        onPressed: () {
                          ref.read(gameBottomViewController.notifier).state =
                              GameViewBottomViewEnum.camera;

                          ref.read(isImageCapturedProvider.notifier).state =
                              false;
                        },
                      )),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        padding: const EdgeInsets.all(16),
                        icon: const Icon(
                          CupertinoIcons.arrow_up,
                          color: AppColors.whiteTextColor,
                        ),
                        iconSize: 36,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              AppColors.blueButtonColor),
                        ),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          ref.read(gameBottomViewController.notifier).state =
                              GameViewBottomViewEnum.waiting;
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
    ),
  );
}
