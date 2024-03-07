import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/pages/game_over_page.dart';
import 'package:vista/widgets/camera_cupertino_popup_surface.dart';
import 'package:vista/widgets/explain_cupertino_popup_surface.dart';

//Dont understand this fully yet, but very important that default is .camera not .explain, bec
//our first called is .explain and if it is also default we get multiple popups
final gameBottomViewController = StateProvider<GameViewBottomViewEnum>((ref) {
  return GameViewBottomViewEnum.camera;
});

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  // Track the last value to avoid multiple popups
  GameViewBottomViewEnum? lastValue;

  // Flag to track whether a popup is already displayed
  bool isPopupDisplayed = false;

  @override
  Widget build(BuildContext context) {
    final currentValue = ref.watch(gameBottomViewController);
    const int items = 3;

    // Check if the current value is different from the last value
    if (currentValue != lastValue) {
      lastValue = currentValue;

      // Show popup if the value has changed and no popup is currently displayed
      if (!isPopupDisplayed) {
        isPopupDisplayed = true; // Set flag to true
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showPopup(currentValue, context);
        });
      }
    }

    return CupertinoPageScaffold(
        child: PopScope(
            canPop: false,
            child: CupertinoPageScaffold(
                navigationBar: const CupertinoNavigationBar(
                  automaticallyImplyLeading: false,
                  trailing: Align(
                    widthFactor: 1.0,
                    alignment: Alignment.center,
                    child: Icon(
                      CupertinoIcons.exclamationmark_octagon,
                      color: AppColors.whiteTextColor,
                    ),
                  ),
                  middle: Text(
                    "1/10",
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  leading: Align(
                    widthFactor: 1.0,
                    alignment: Alignment.center,
                    child: Text(
                      '00:49',
                      style: TextStyle(color: AppColors.whiteTextColor),
                    ),
                  ),
                ),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return Stack(
                      children: [
                        CupertinoScrollbar(
                          child: ListView.separated(
                            itemCount: items,
                            itemBuilder: (context, index) {
                              if (index == items - 1) {
                                if (currentValue ==
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
                                                    .read(
                                                        gameBottomViewController
                                                            .notifier)
                                                    .state =
                                                GameViewBottomViewEnum.gameOver;
                                            print("gameoverr");
                                          }),
                                      LoadingAnimationWidget.flickr(
                                          leftDotColor:
                                              AppColors.whiteTextColor,
                                          rightDotColor:
                                              AppColors.blueButtonColor,
                                          size: 40)
                                    ],
                                  );
                                } else if (currentValue ==
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                      ],
                    );
                  },
                ))));
  }

  void showPopup(GameViewBottomViewEnum newValue, BuildContext context) {
    // Implement your popup logic here based on the new value
    print('GameBottomView changed to: $newValue');

    // Reset the flag when the popup is dismissed
    void onPopupDismissed() {
      isPopupDisplayed = false;
    }

    if (newValue == GameViewBottomViewEnum.camera) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CameraCupertinoPopupSurface(onDismissed: onPopupDismissed);
        },
      );
    } else if (newValue == GameViewBottomViewEnum.explain) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return ExplainCupertinoPopupSurface(onDismissed: onPopupDismissed);
        },
      );
    }
  }
}
