import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/enum/game_bottom_view_enum.dart';
import 'package:vista/pages/game_page.dart';
import 'package:vista/pages/how_it_works_page.dart';

class InstantMatchPage extends StatelessWidget {
  const InstantMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Instant match"),
        ),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //here should be container remove from top
                              Text(
                                "Play The Game.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: AppColors.whiteTextColor),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Instant match is only with singles that are currently online, if you or them go offline the match will disappear.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.greyTextColor),
                              ),
                            ]);
                      }

                      return Stack(
                        children: [
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double imageSize = constraints
                                  .maxWidth; // Set width and height to be the same
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'lib/assets/bigprofilephoto.png',
                                  fit: BoxFit.cover,
                                  width: imageSize,
                                  height: imageSize,
                                ),
                              );
                            },
                          ),
                          const Positioned(
                            top: 16,
                            left: 16,
                            child: Text(
                              "2.1 Miles",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.whiteTextColor),
                            ),
                          ),
                          Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //here should be container remove from top
                                          Text(
                                            "Larry Burns, 29",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color:
                                                    AppColors.whiteTextColor),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),

                                          Text(
                                            "Manager at EOS systems",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColors
                                                    .darkGreyTextColor),
                                          ),
                                        ]),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      HapticFeedback.mediumImpact();

                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => GamePage(),
                                        ),
                                      );
                                      //we are making sure state is going to show the explain view, this is why we wrapped this enire thing in a consumer widget to give us access to ref
                                      ref
                                              .read(gameBottomViewController
                                                  .notifier)
                                              .state =
                                          GameViewBottomViewEnum.explain;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.yellowButtonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50.0), // Half of the button height makes it an oval shape
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              20.0), // Adjust the padding as needed
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 4),
                                        Text(
                                          'Play',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.blackTextColor),
                                        ),
                                        // Your icon
                                        SizedBox(
                                            width:
                                                8), // Adjust spacing between icon and text
                                        Icon(
                                          CupertinoIcons.bolt_fill,
                                          color: AppColors.blackTextColor,
                                        ),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 28,
                      );
                    },
                    itemCount: 5),
              ),
            );
          },
        ));
  }
}
