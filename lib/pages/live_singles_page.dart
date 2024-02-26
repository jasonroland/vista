import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/widgets/bottom_live_single_wave_skip.dart';
import 'package:vista/widgets/live_single_card.dart';
import 'package:vista/widgets/live_single_card_new.dart';

class LiveSinglesPage extends StatelessWidget {
  const LiveSinglesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Live singles"),
        ),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(
                              top: 36), // Adjust the top padding as needed
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // LiveSingleCard(maxWidth: constraints.maxWidth),
                            SizedBox(
                              //this needs to be fixed for landscape not sure what the issue is
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: LiveSingleCardNew(),
                              // child: AppinioSwiper(
                              //   loop: true,
                              //   cardBuilder: (BuildContext context, int index) {
                              //     return LiveSingleCard(
                              //         maxWidth: constraints.maxWidth);
                              //   },
                              //   cardCount: 3,
                              // ),
                            )
                            // Add other widgets as needed
                          ],
                        ),
                      ),
                      BottomLiveSingleWaveSkip(maxWidth: constraints.maxWidth),
                    ],
                  ),
                ),
              );

              // return Padding(
              //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              //   child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Expanded(
              //           child: ListView(
              //             physics: const BouncingScrollPhysics(),
              //             children: [
              //               // Adjust the height as needed
              //               const SizedBox(height: 36),
              //               LiveSingleCard(maxWidth: constraints.maxWidth),
              //             ],
              //           ),
              //         ),
              //         BottomLiveSingleWaveSkip(maxWidth: constraints.maxWidth),
              //       ]),
              // );
            });
          },
        ));
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vista/widgets/bottom_live_single_wave_skip.dart';
// import 'package:vista/widgets/live_single_card.dart';

// class LiveSinglesPage extends StatefulWidget {
//   const LiveSinglesPage({Key? key}) : super(key: key);

//   @override
//   _LiveSinglesPageState createState() => _LiveSinglesPageState();
// }

// class _LiveSinglesPageState extends State<LiveSinglesPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 750),
//       vsync: this,
//     );
//     _controller.forward(); // Trigger the animation
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text("Live singles"),
//       ),
//       child: Consumer(
//         builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           return LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 48, right: 48, top: 48),
//                     child: SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(0, -1),
//                         end: const Offset(0, .2),
//                       ).animate(_controller),
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: LiveSingleCard(maxWidth: constraints.maxWidth),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 48),
//                       child: ListView(
//                         physics: const BouncingScrollPhysics(),
//                         children: [
//                           // Additional list items can be added here
//                         ],
//                       ),
//                     ),
//                   ),
//                   BottomLiveSingleWaveSkip(maxWidth: constraints.maxWidth),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
