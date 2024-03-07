import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/pages/game_page.dart';

class ExplainCupertinoPopupSurface extends StatelessWidget {
  final VoidCallback onDismissed; // Add the onDismissed callback
  const ExplainCupertinoPopupSurface({Key? key, required this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, //prob dont need this
      width: double.infinity, // Set width to be as wide as the whole screen
      child: CupertinoPopupSurface(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Consumer(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Uncover Personality",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.whiteTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "Show a window into your life by\nanswering prompts with an\nhonest image",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.greyTextColor),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CupertinoButton.filled(
                        child: const Text(
                            "Lets go!"), //maybe needs to be a bit bolder, idk
                        onPressed: () {
                          HapticFeedback.mediumImpact();

                          //close popup
                          Navigator.pop(context);
                          //ref.read(showPopupController.notifier).state = true;
//need

                          ref.read(gameBottomViewController.notifier).state =
                              GameViewBottomViewEnum.camera;
                          onDismissed();
                        }),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
