import 'package:flutter/cupertino.dart';
import 'package:vista/constants/app_colors.dart';

class LiveSingleCard extends StatelessWidget {
  final double maxWidth;
  const LiveSingleCard({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          //empty container
          AspectRatio(
            aspectRatio:
                1, //keep it a square, not sure why its needed but without it gets weird
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: AppColors.darkGreyButtonBackgroundColor),
              //this puts a container behind the image that is the exact height of the image which is set to the maxwidth available
              height: maxWidth,
            ),
          ),
          Container(
            width: maxWidth,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppColors.greyNotTransparent),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Larry Burns, 29",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.whiteTextColor),
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
                          color: AppColors.greyTextColor),
                    ),
                  ]),
            ),
          ),
        ],
      ),
      Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1, //this makes the image a square
              child: Image.asset(
                'lib/assets/bigprofilephoto.png',
                fit: BoxFit.cover, //image isnt showing a square, look into it
                width: maxWidth,
                height: maxWidth,
              ),
            ),
          ),
          const Positioned(
            top: 16,
            left: 16,
            child: Text(
              "2.1 Miles",
              overflow: TextOverflow.ellipsis,
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
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: CupertinoColors.activeGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: AppColors.whiteTextColor)),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Live Now",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
