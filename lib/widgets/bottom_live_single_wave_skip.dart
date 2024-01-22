import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';

class BottomLiveSingleWaveSkip extends StatelessWidget {
  final double maxWidth;
  const BottomLiveSingleWaveSkip({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      decoration: const BoxDecoration(
          color: AppColors.darkGreyButtonBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          children: [
            SizedBox(height: 16),
            Transform.rotate(
              angle: 45 * 3.141592653589793238462 / 180,
              child: const Icon(
                CupertinoIcons.hand_raised_fill,
                color: AppColors.yellowButtonColor,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Show interest with a wave, this will put\nyour profile in their “Instant Matches”.",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.whiteTextColor),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Icon(
                    CupertinoIcons.slash_circle,
                    color: AppColors.greyTextColor,
                  ),
                  //overriding standard cupertino button padding which is normally 16, for the left side so icon is closer to it
                  CupertinoButton(
                      padding: const EdgeInsets.only(
                          left: 8, right: 16, top: 16, bottom: 16),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: AppColors.greyTextColor),
                      ),
                      onPressed: () {}),
                ]),
                Container(
                  height: 24,
                  width: 3,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.greyTextColor),
                ),
                CupertinoButton(
                    child: const Text(
                      "Wave",
                      style: TextStyle(color: AppColors.yellowButtonColor),
                    ),
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
