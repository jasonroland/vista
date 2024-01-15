import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/home_page.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
          child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Game Over",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Text(
                    "Get to know Jules better", //Would you like to
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.whiteTextColor),
                    //textAlign: TextAlign.center,
                  ),
                  Spacer(),
                ]),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Text(
                    "Begin a conversation by sharing\nyour instagram",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                  Spacer(),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              CupertinoButton.filled(
                  child: Text(
                    "Share my Instagram",
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => HomePage()));
                  }),
              CupertinoButton(
                  child: Text(
                    "No, play again",
                    style: TextStyle(color: AppColors.greyTextColor),
                  ),
                  onPressed: () {})
            ],
          ),
          // ),
        ),
      )),
    );
  }
}
