import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vista/constants/app_colors.dart';

class LiveSingleCardNew extends StatelessWidget {
  const LiveSingleCardNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              // color: AppColors.darkGreyButtonBackgroundColor,
              borderRadius: BorderRadius.circular(8)),
          // height: 400,
          width: 400,
          child: Column(
            children: [
              SizedBox(height: 32),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 3,
                        color: AppColors.whiteTextColor,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackTextColor
                            .withOpacity(.75), //Colors.yellow.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(3, 0),
                      ),
                      BoxShadow(
                        color: AppColors
                            .yellowButtonColor, //Colors.yellow.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(3, 0),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        AssetImage('lib/assets/bigprofilephoto.png'),
                  )),
              SizedBox(height: 32),
              Text(
                "Larry Burns, 29",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteTextColor),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Manager at EOS systems",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyTextColor),
              ),
              SizedBox(height: 32),
              // ActionSlider.dual(
              //   sliderBehavior: SliderBehavior.stretch,
              //   // backgroundBorderRadius: BorderRadius.circular(10.0),
              //   // foregroundBorderRadius: BorderRadius.circular(10.0),
              //   rolling: true,
              //   width: 300.0,
              //   backgroundColor: Colors.black,
              //   toggleColor: Colors.yellow,
              //   failureIcon: Icon(
              //     CupertinoIcons.slash_circle,
              //     color: AppColors.blackTextColor,
              //   ),
              //   successIcon: const Icon(Icons.back_hand, size: 28.0),
              //   icon: Transform.rotate(
              //     angle: 45 * 3.141592653589793238462 / 180,
              //     child: const Icon(Icons.back_hand, size: 28.0),
              //   ),

              //   startChild: const Text(
              //       'Skip'), //Text(state.position.toStringAsFixed(2)),
              //   endChild: const Text('Wave'),

              //   startAction: (controller) async {
              //     //controller.loading(); //starts loading animation
              //     // await Future.delayed(const Duration(seconds: 3));
              //     controller.failure(); //starts success animation
              //     await Future.delayed(const Duration(seconds: 1));
              //     controller.reset(); //resets the slider
              //   },
              //   endAction: (controller) async {
              //     // controller.loading(); //starts loading animation
              //     //  await Future.delayed(const Duration(seconds: 3));
              //     controller.success(); //starts success animation
              //     await Future.delayed(const Duration(seconds: 1));
              //     controller.reset(); //resets the slider
              //   },
              // ),
            ],
          ),
        )
      ],
    );
  }
}
