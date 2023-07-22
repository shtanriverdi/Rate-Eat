import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:micro_yelp/core/utils/utils_index.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: widthCalculator(screenWidth: width, width: 180),
          height: heightCalculator(screenHeight: height, height: 250),
          decoration: BoxDecoration(
            color: MicroYelpColor.opaqueOrange,
            borderRadius: BorderRadius.circular(height * 0.02),
          ),
        ),
        Container(
          margin: EdgeInsets.all(width * 0.07),
          width: widthCalculator(screenWidth: width, width: 150),
          height: heightCalculator(screenHeight: height, height: 230),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
            border: Border.all(
              color: MicroYelpColor.primaryColor,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(
              Fluent.cube_link_20_filled,
              size: width * 0.08,
              color: MicroYelpColor.primaryColor,
            ),
            SizedBox(
              height: height * 0.005,
            ),
            const Text(
              "Add product",
              style: TextStyle(color: MicroYelpColor.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
