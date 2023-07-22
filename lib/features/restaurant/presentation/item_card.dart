import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';

class ItemCards extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final double averageRating;
  const ItemCards({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.averageRating,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return   Container(
      margin: EdgeInsets.only(
          left: widthCalculator(screenWidth: width, width: 14),
          right: widthCalculator(screenWidth: width, width: 14),
          bottom: widthCalculator(screenWidth: width, width: 5)),
      width: widthCalculator(screenWidth: width, width: 400),
      height: heightCalculator(screenHeight: height, height: 180),
      child: Card(
        color: MicroYelpColor.backgroundForitemdetail,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.023),
        ),
        elevation: 0.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: widthCalculator(screenWidth: width, width: 15),
                  vertical: heightCalculator(screenHeight: height, height: 20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(height * 0.014),
                child: Image(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                    height: heightCalculator(screenHeight: height, height: 150),
                    width: widthCalculator(screenWidth: width, width: 150)),
              ),
            ),
            SizedBox(
              height: heightCalculator(screenHeight: height, height: 150),
              width: widthCalculator(screenWidth: width, width: 1),
            ),
            Expanded(
              
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:heightCalculator(screenHeight: height, height: 10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MicroYelpText.smallCardTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      price,
                      style: MicroYelpText.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: heightCalculator(screenHeight: height, height: 16),
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MicroYelpText.description1,
                    ),
                    SizedBox(height: heightCalculator(screenHeight: height, height: 10,)),
                      StarRating(averageItemRating: averageRating, starSize: 20, ignoreGestures: true, allowHalfRating: true,),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}