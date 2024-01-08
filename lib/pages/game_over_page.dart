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
          // navigationBar: const CupertinoNavigationBar(
          //   middle: Text(""),
          //   automaticallyImplyLeading: false,
          // ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Would you like to get to know\nJules better?",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.whiteTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 32,
              ),
              CupertinoButton.filled(
                  child: Text(
                    "Yes, share my Insta",
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
