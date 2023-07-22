import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_yelp/core/core.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: widthCalculator(screenWidth: width, width: 160),
        height: heightCalculator(screenHeight: height, height: 50),
        padding: EdgeInsets.only(
            left: widthCalculator(screenWidth: width, width: 15)),
        decoration: BoxDecoration(
            color: MicroYelpColor.inputField,
            borderRadius: BorderRadius.circular(
                widthCalculator(screenWidth: width, width: 30))),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 4),
                  ),
                  Image.asset(
                    "assets/person_img_2.png",
                    height: heightCalculator(screenHeight: height, height: 25),
                    width: widthCalculator(screenWidth: width, width: 25),
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 14),
                  )
                ],
              ),
            ),
            SizedBox(
              width: widthCalculator(screenWidth: width, width: 3.5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mike   ",
                      style: MicroYelpText.bottomNavigationLabel,
                    ),
                    const StarRating(
                        averageItemRating: 4.2,
                        starSize: 12,
                        ignoreGestures: true,
                        allowHalfRating: true)
                  ],
                ),
                Text(
                  "Aug 14, 2022",
                  style: GoogleFonts.urbanist(
                      fontSize: 6,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF787878)),
                ),
                Text(
                  "Lorem Ipsum is simply text of ",
                  style: GoogleFonts.urbanist(
                      fontSize: 6,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF787878)),
                ),
                Text(
                  "the printing more texts.",
                  style: GoogleFonts.urbanist(
                      fontSize: 6,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF787878)),
                ),
              ],
            )
          ],
        ));
  }
}
