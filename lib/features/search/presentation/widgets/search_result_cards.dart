import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/item/bloc/item_bloc.dart';
import 'package:micro_yelp/features/item/presentation/item_detail.dart';
import '../../../../core/presentation/widgets/star_rating_flexible.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/width_and_height_converter.dart';

class SearchResultCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final String id;
  final String description;
  final double averageRating;
  final String address;
  final String numOfReviews;
  final String restaurantName;
  const SearchResultCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.averageRating,
    required this.address,
    required this.restaurantName,
    required this.numOfReviews,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ItemBloc>(context).add(ItemLoadEvent(itemId: id));
        Navigator.pushNamed(context, ItemDetail.route);
      },
      child: SizedBox(
        width: widthCalculator(screenWidth: width, width: 400),
        height: heightCalculator(screenHeight: height, height: 180),
        child: Card(
          color: MicroYelpColor.inputField,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                widthCalculator(screenWidth: width, width: 10)),
          ),
          elevation: 0.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(
                    widthCalculator(screenWidth: width, width: 8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      widthCalculator(screenWidth: width, width: 10)),
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                      height:
                          heightCalculator(screenHeight: height, height: 150),
                      width: widthCalculator(screenWidth: width, width: 150)),
                  // child: Image.network(
                  //   imageUrl,
                  //   fit: BoxFit.cover,
                  //   height: heightCalculator(screenHeight: height, height: 150),
                  //   width: widthCalculator(screenWidth: width, width: 150),
                  // ),
                ),
              ),
              SizedBox(
                width: widthCalculator(screenWidth: width, width: 7),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: MicroYelpText.smallCardTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "$price BIRR",
                          style: MicroYelpText.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        restaurantName,
                        style: MicroYelpText.restaurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    StarRating(
                      averageItemRating: averageRating,
                      allowHalfRating: true,
                      starSize: width * 0.06,
                      ignoreGestures: true,
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Text(
                      "$numOfReviews reviews",
                      style: MicroYelpText.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 23),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: MicroYelpColor.primaryColor,
                          size: widthCalculator(screenWidth: width, width: 20),
                        ),
                        Expanded(
                          child: Text(
                            address,
                            style: MicroYelpText.watermark,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightCalculator(screenHeight: height, height: 9),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
