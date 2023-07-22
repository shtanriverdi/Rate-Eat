import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';

class BusinessItemCard extends StatelessWidget {
  final String itemImage;
  final String itemName;
  final String itemPrice;
  final String itemDesc;

  const BusinessItemCard(
      {Key? key,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      required this.itemDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: widthCalculator(screenWidth: width, width: 200),
      height: heightCalculator(screenHeight: height, height: 290),
      child: Card(
        elevation: 3.0,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.02),
          borderSide: BorderSide.none,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.02),
              child: Image.asset(
                MicroYelpImage.burgerImage,
                fit: BoxFit.cover,
                height: heightCalculator(
                  screenHeight: height,
                  height: 132,
                ),
                width: widthCalculator(
                  screenWidth: width,
                  width: 200,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: width * 0.04, left: width * 0.02, right: width * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: MicroYelpText.smallCardTitle,
                  ),
                  SizedBox(
                    height: height * 0.003,
                  ),
                  Text(
                    itemPrice,
                    style: MicroYelpText.price,
                  ),
                  SizedBox(
                    height: height * 0.003,
                  ),
                  Text(
                    itemDesc,
                    style: MicroYelpText.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
