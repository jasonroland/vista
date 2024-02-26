import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/instant_match_page.dart';
import 'package:vista/widgets/live_single_card_new.dart';

class LiveSinglesNewPage extends StatelessWidget {
  const LiveSinglesNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        // trailing: CupertinoButton(child: Text("Go Offline"), onPressed: () {}),
        middle: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.globe),
                    SizedBox(width: 4),
                    Text("321")
                  ],
                ),
                Container(
                  width: 1,
                )
                // CupertinoButton(
                //     padding: EdgeInsets.all(0),
                //     child: Text("close"),
                //     onPressed: () {}),
              ],
            ),
            Positioned(
              left: 16,
              child: CupertinoButton(
                  padding: EdgeInsets.all(0),
                  child: Text("Go Offline"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
        // CupertinoButton(child: Text("close"), onPressed: () {}),

        // leading: CupertinoButton(child: Text("close"), onPressed: () {}),

        // trailing: Container(
        //   width: 1,
        // ),

        // Text("321"),
        //  trailing: Icon(CupertinoIcons.globe),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 32),
            // Text(
            //   "Live Singles",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            // ),
            Padding(padding: EdgeInsets.all(16), child: LiveSingleCardNew()),
            ActionSlider.dual(
              sliderBehavior: SliderBehavior.stretch,
              // backgroundBorderRadius: BorderRadius.circular(10.0),
              // foregroundBorderRadius: BorderRadius.circular(10.0),
              rolling: true,
              width: 300.0,
              backgroundColor: AppColors.greyNotTransparent,

              toggleColor: Colors.yellow,
              failureIcon: Icon(
                CupertinoIcons.slash_circle,
                color: AppColors.blackTextColor,
              ),
              successIcon: const Icon(Icons.back_hand, size: 28.0),
              icon: Transform.rotate(
                angle: 45 * 3.141592653589793238462 / 180,
                child: const Icon(Icons.back_hand, size: 28.0),
              ),

              startChild:
                  const Text('Skip'), //Text(state.position.toStringAsFixed(2)),
              endChild: const Text('Wave'),

              startAction: (controller) async {
                //controller.loading(); //starts loading animation
                // await Future.delayed(const Duration(seconds: 3));
                controller.failure(); //starts success animation
                await Future.delayed(const Duration(seconds: 1));
                controller.reset(); //resets the slider
              },
              endAction: (controller) async {
                // controller.loading(); //starts loading animation
                //  await Future.delayed(const Duration(seconds: 3));
                controller.success(); //starts success animation
                await Future.delayed(const Duration(seconds: 1));
                controller.reset(); //resets the slider
              },
            ),

            SizedBox(height: 32),
            CupertinoListSection(
                // decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                // color: CupertinoTheme.of(context).barBackgroundColor),
                children: <CupertinoListTile>[
                  CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.circle_fill,
                      color: AppColors.yellowButtonColor,
                    ),
                    title: const Text("Matches"),
                    trailing: const CupertinoListTileChevron(),
                    additionalInfo: const CircleAvatar(
                      backgroundColor: AppColors.yellowButtonColor,
                      radius: 16,
                      child: Text("2",
                          style: TextStyle(color: AppColors.darkGreyTextColor)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const InstantMatchPage()));
                    },
                  ),
                ]),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "You are now live, feel free to leave the app. You will get a notification when you have a match.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.greyTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
