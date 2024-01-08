import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/widgets/game_bottom_view.dart';

final gameBottomViewController = StateProvider<GameViewBottomViewEnum>((ref) {
  return GameViewBottomViewEnum.explain;
});

class GamePage extends ConsumerWidget {
  GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
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
              middle: Text("1/10"),
              leading: Align(
                widthFactor: 1.0,
                alignment: Alignment.center,
                child: Text('00:49'),
              ),
            ),
            child: Stack(
              children: [
                CupertinoScrollbar(
                  child: ListView.separated(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GameBottomView(
                            bottomViewType: ref.watch(gameBottomViewController),
                          ),
                        ),
                      ),
                    ))
              ],
            )));
  }
}
