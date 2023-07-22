import 'package:flutter/material.dart';
import 'package:micro_yelp/features/item/presentation/widgets/star.dart';
import '../../../../core/utils/constants.dart';

class StarBar extends StatelessWidget {
  final double width;
  final int numOfStars;

  const StarBar({
    Key? key,
    required this.width,
    required this.numOfStars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              if (index < numOfStars)
                Star(size: width, color: MicroYelpColor.primaryColor)
              else
                Star(size: width, color: MicroYelpColor.iconColor),
            ],
          );
        });
  }
}
