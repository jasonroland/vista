import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/game_page.dart';
import 'package:vista/pages/how_it_works_page.dart';

class GetToKnowpage extends StatelessWidget {
  const GetToKnowpage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Live match"),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Meet your match",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'lib/assets/smallprofilephoto.png',
                          width: 240,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Jules Morgan",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteTextColor),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "27 Designer at Michelle",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyTextColor),
                      )
                    ],
                  ),
                ),
                Spacer(),
                CupertinoButton.filled(
                    child: Text(
                      "Let's match",
                      style: TextStyle(color: AppColors.whiteTextColor),
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();

                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => GamePage(),
                        ),
                      );

                      // Navigator.of(context).push(
                      //     CupertinoPageRoute(builder: (context) => GamePage()));
                    }),
                CupertinoButton(
                    child: Text(
                      "Skip",
                      style: TextStyle(color: AppColors.greyTextColor),
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ));
  }
}
