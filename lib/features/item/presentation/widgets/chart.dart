import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';

class Chart extends StatelessWidget {
  final int one;
  final int two;
  final int three;
  final int four;
  final int five;

  const Chart(
      {super.key,
      required this.one,
      required this.two,
      required this.three,
      required this.four,
      required this.five});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<int> ratings = [];
    ratings.add(one);
    ratings.add(two);
    ratings.add(three);
    ratings.add(four);
    ratings.add(five);
    int maximum =
        ratings.reduce((value, element) => value > element ? value : element);
    return ListView.builder(
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                EdgeInsets.all(widthCalculator(screenWidth: width, width: 5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widthCalculator(screenWidth: width, width: 5),
                  child: Text(
                    '${5 - index}',
                    style: MicroYelpText.watermark,
                  ),
                ),
                Stack(children: [
                  Container(
                    height: heightCalculator(screenHeight: height, height: 6),
                    width: widthCalculator(screenWidth: width, width: 110),
                    decoration: const BoxDecoration(
                        color: MicroYelpColor.greyBorder,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  if (ratings[5 - index - 1] != 0)
                    Container(
                      height: heightCalculator(screenHeight: height, height: 6),
                      width: widthCalculator(screenWidth: width, width: 110) *
                          ratings[5 - index - 1] /
                          maximum,
                      decoration: BoxDecoration(
                          color: MicroYelpColor.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              widthCalculator(screenWidth: width, width: 5)))),
                    ),
                ])
              ],
            ),
          );
        });
  }
}
