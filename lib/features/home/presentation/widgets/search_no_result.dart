import 'package:flutter/material.dart';
import 'package:micro_yelp/core/utils/utils_index.dart';

class NoResult extends StatelessWidget {
  const NoResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: widthCalculator(screenWidth: width, width: 56),
        right: widthCalculator(screenWidth: width, width: 75),
        top: heightCalculator(screenHeight: height, height: 70),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MicroYelpImage.noResultsImage,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 43),
          ),
          Text(
            "No Results Found!",
            style: MicroYelpText.internalSubTitle,
          ),
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 12),
          ),
          Text(
            "please check spelling or try other",
            style: MicroYelpText.watermark,
          ),
          Text(
            "key words",
            style: MicroYelpText.watermark,
          )
        ],
      ),
    );
  }
}
