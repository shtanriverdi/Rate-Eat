import 'package:flutter/material.dart';
import 'package:micro_yelp/core/utils/constants.dart';

import '../../../../core/utils/width_and_height_converter.dart';

class RecentReviewCard extends StatelessWidget {
  final String personName;
  final String description;
  final String imageUrl;
  final String lastUpdatedDate;
  final int itemRating;

  const RecentReviewCard({
    Key? key,
    required this.personName,
    required this.description,
    required this.lastUpdatedDate,
    required this.itemRating,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(width * 0.02),
        height: heightCalculator(screenHeight: height, height: 105),
        width: widthCalculator(screenWidth: width, width: 320),
        decoration: BoxDecoration(
            color: MicroYelpColor.inputField,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 200, 200, 200),
                spreadRadius: 0.1,
                blurRadius: 2,
                offset: Offset(0.1, 0.1), // Shadow position
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03))),
        child: Row(
          children: [
            CircleAvatar(
              radius: height * 0.04,
              backgroundImage: AssetImage(imageUrl),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  personName,
                  overflow: TextOverflow.ellipsis,
                  style: MicroYelpText.smallReviewTitle,
                ),
                SizedBox(
                  width: width * 0.35,
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: MicroYelpText.description,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      size: width * 0.05,
                      Icons.star,
                      color: MicroYelpColor.firstSplashScreen,
                    ),
                    Icon(
                      size: width * 0.05,
                      Icons.star,
                      color: MicroYelpColor.firstSplashScreen,
                    ),
                    Icon(
                      size: width * 0.05,
                      Icons.star,
                      color: MicroYelpColor.firstSplashScreen,
                    ),
                    Icon(
                      size: width * 0.05,
                      Icons.star,
                      color: MicroYelpColor.firstSplashScreen,
                    ),
                    Icon(
                      size: width * 0.05,
                      Icons.star,
                      color: MicroYelpColor.firstSplashScreen,
                    ),
                  ],
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                lastUpdatedDate,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: MicroYelpText.description,
              ),
            )
          ],
        ),
      ),
    );
  }
}
