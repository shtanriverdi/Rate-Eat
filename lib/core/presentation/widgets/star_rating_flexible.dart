import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:micro_yelp/core/core.dart';

class StarRating extends StatelessWidget {
  final double averageItemRating;
  final double starSize;
  final bool ignoreGestures;
  final bool allowHalfRating;

  const StarRating(
      {Key? key,
      required this.averageItemRating,
      required this.starSize,
      required this.ignoreGestures,
      required this.allowHalfRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGestures,
      initialRating: averageItemRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: allowHalfRating,
      itemCount: 5,
      itemSize: starSize,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: MicroYelpColor.starColor,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
