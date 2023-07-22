import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/item/presentation/widgets/chart.dart';

// ignore: must_be_immutable
class RatingCard extends StatelessWidget {
  int one;
  int two;
  int three;
  int four;
  int five;
  String averageRating;
  String numberOfReviews;

  RatingCard(
      {super.key,
      required this.one,
      required this.two,
      required this.three,
      required this.four,
      required this.five,
      required this.averageRating,
      required this.numberOfReviews});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return SizedBox(
      height: heightCalculator(screenHeight: height, height: 180),
      child: Container(
        decoration: BoxDecoration(
            color: MicroYelpColor.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(
                widthCalculator(screenWidth: width, width: 10)))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(
                left: widthCalculator(screenWidth: width, width: 28)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      averageRating,
                      style: MicroYelpText.mainTitle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: heightCalculator(
                              screenHeight: height, height: 5)),
                      child: Text(
                        '/5',
                        style: MicroYelpText.internalSubTitle,
                      ),
                    ),
                  ],
                ),
                Text('Based on $numberOfReviews Reviews',
                    style: MicroYelpText.watermark),
                SizedBox(
                  width: widthCalculator(screenWidth: width, width: 175),
                  height: heightCalculator(screenHeight: height, height: 40),
                  child: StarRating(
                      allowHalfRating: true,
                      starSize: widthCalculator(screenWidth: width, width: 30),
                      ignoreGestures: true,
                      averageItemRating: double.parse(averageRating)),
                )
              ],
            ),
          ),
          SizedBox(
              height: heightCalculator(screenHeight: height, height: 150),
              width: widthCalculator(screenWidth: width, width: 175),
              child: Chart(
                  one: one, two: two, three: three, four: four, five: five))
        ]),
      ),
    );
  }
}