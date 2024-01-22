// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vista/widgets/bottom_live_single_wave_skip.dart';
// import 'package:vista/widgets/live_single_card.dart';

// class LiveSinglesPage extends StatelessWidget {
//   const LiveSinglesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//         navigationBar: const CupertinoNavigationBar(
//           middle: Text("Live singles"),
//         ),
//         child: Consumer(
//           builder: (BuildContext context, WidgetRef ref, Widget? child) {
//             return LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//               return Column(children: [
//                 Expanded(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 48, right: 48, top: 48),
//                     //listview for scroll in smaller devices
//                     child: ListView(
//                       physics:
//                           const BouncingScrollPhysics(), //this sets the scrollbounce only if there is scrollable content
//                       children: [
//                         LiveSingleCard(maxWidth: constraints.maxWidth),
//                       ],
//                     ),
//                   ),
//                 ),
//                 BottomLiveSingleWaveSkip(maxWidth: constraints.maxWidth),
//               ]);
//             });
//           },
//         ));
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/widgets/bottom_live_single_wave_skip.dart';
import 'package:vista/widgets/live_single_card.dart';

class LiveSinglesPage extends StatefulWidget {
  const LiveSinglesPage({Key? key}) : super(key: key);

  @override
  _LiveSinglesPageState createState() => _LiveSinglesPageState();
}

class _LiveSinglesPageState extends State<LiveSinglesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _controller.forward(); // Trigger the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 48, right: 48, top: 48),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: const Offset(0, .2),
                      ).animate(_controller),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: LiveSingleCard(maxWidth: constraints.maxWidth),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // Additional list items can be added here
                        ],
                      ),
                    ),
                  ),
                  BottomLiveSingleWaveSkip(maxWidth: constraints.maxWidth),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
