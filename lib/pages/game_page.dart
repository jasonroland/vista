import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/pages/game_over_page.dart';
import 'package:vista/widgets/game_bottom_view.dart';

final gameBottomViewController = StateProvider<GameViewBottomViewEnum>((ref) {
  return GameViewBottomViewEnum.explain;
});

class GamePage extends ConsumerWidget {
  GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentState = ref.watch(gameBottomViewController);
    //since when we bring up the camera view we add a opacity, but dont have opacity on the nav bar, we are changing the color manually to be darker when camera is shown
    final Color navigationBarTextColor =
        (currentState == GameViewBottomViewEnum.camera)
            ? AppColors.darkGreyButtonBackgroundColor
            : AppColors.whiteTextColor;

    final int items = 3;
    //var currentState = ref.watch(gameBottomViewController.notifier).state;

    return PopScope(
        canPop: false,
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              automaticallyImplyLeading: false,
              trailing: Align(
                widthFactor: 1.0,
                alignment: Alignment.center,
                child: Icon(
                  CupertinoIcons.exclamationmark_octagon,
                  color: navigationBarTextColor,
                ),
              ),
              middle: Text(
                "1/10",
                style: TextStyle(color: navigationBarTextColor),
              ),
              leading: Align(
                widthFactor: 1.0,
                alignment: Alignment.center,
                child: Text(
                  '00:49',
                  style: TextStyle(color: navigationBarTextColor),
                ),
              ),
            ),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Stack(
                  children: [
                    CupertinoScrollbar(
                      child: ListView.separated(
                        itemCount: items,
                        itemBuilder: (context, index) {
                          if (index == items - 1) {
                            if (currentState ==
                                GameViewBottomViewEnum.waiting) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      child: const Text(
                                        "Waiting for Jules",
                                        style: TextStyle(
                                            color: AppColors.greyTextColor),
                                      ),
                                      onPressed: () {
                                        ref
                                                .read(gameBottomViewController
                                                    .notifier)
                                                .state =
                                            GameViewBottomViewEnum.gameOver;
                                        print("gameoverr");
                                      }),
                                  LoadingAnimationWidget.flickr(
                                      leftDotColor: AppColors.whiteTextColor,
                                      rightDotColor: AppColors.blueButtonColor,
                                      size: 40)
                                ],
                              );
                            } else if (currentState ==
                                GameViewBottomViewEnum.gameOver) {
                              return Center(
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 32),
                                    child: CupertinoButton.filled(
                                        padding: const EdgeInsets.all(16),
                                        child: const Text(
                                          "Game over",
                                          style:
                                              TextStyle(), //maybe needs to be a bit bolder, idk
                                        ),
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const GameOverPage()));
                                          // ref
                                          //         .read(gameBottomViewController
                                          //             .notifier)
                                          //         .state =
                                          //     GameViewBottomViewEnum.explain;
                                        })),
                              );
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'lib/assets/smallprofilephoto.png',
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "My most prized\npossession is",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'lib/assets/coffee.png',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    ),
                    //here we are watching if the camera view is up and if yes we add a opacity over the other widgets to show focus
                    if (currentState == GameViewBottomViewEnum.camera) ...[
                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.5), // Adjust opacity as needed
                        ),
                      ),
                    ],
                    if (currentState == GameViewBottomViewEnum.camera ||
                        currentState == GameViewBottomViewEnum.explain) ...[
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GameBottomView(
                                  bottomViewType: currentState,
                                ),
                              ),
                            ),
                          ))
                    ]
                  ],
                );
              },
            )));
  }
}
