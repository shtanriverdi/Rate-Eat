import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/utils/constants.dart';
import '../../../../core/presentation/widgets/star_rating_flexible.dart';
import '../../../../core/utils/width_and_height_converter.dart';
import '../../../item/bloc/item_bloc.dart';
import '../../../item/presentation/item_detail.dart';

class ItemCard extends StatelessWidget {
  final String itemId;
  final String itemTitle;
  final String price;
  final String restaurantName;
  final String imageUrl;
  final double averageItemRating;

  const ItemCard({
    Key? key,
    required this.itemTitle,
    required this.price,
    required this.restaurantName,
    required this.imageUrl,
    required this.averageItemRating,
    required this.itemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<ItemBloc>(context).add(ItemLoadEvent(itemId: itemId));
          Navigator.pushNamed(context, ItemDetail.route);
        },
        child: Container(
          height: heightCalculator(screenHeight: height, height: 257),
          width: widthCalculator(screenWidth: width, width: 193),
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
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.03),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: width,
                  height: height * 0.147,
                  placeholder: Image.asset(
                          alignment: Alignment.center,
                          fit: BoxFit.scaleDown,
                          height: height * 0.02,
                          'assets/loading.gif')
                      .image,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.fitWidth,
                      width: width * 0.5,
                      height: height * 0.147,
                    );
                  },
                  image: Image.network(
                    imageUrl,
                  ).image,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: MicroYelpColor.inputField,
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.03))),
                padding: EdgeInsets.all(width * 0.015),
                height: heightCalculator(screenHeight: height, height: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 7,
                          child: Text(
                            itemTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: MicroYelpText.smallCardTitle,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Text(
                            "$price BIRR",
                            maxLines: 1,
                            style: MicroYelpText.price,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                      child: Text(
                        restaurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MicroYelpText.restaurantName,
                      ),
                    ),
                    StarRating(
                      ignoreGestures: true,
                      allowHalfRating: true,
                      averageItemRating: averageItemRating,
                      starSize: width * 0.06,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
