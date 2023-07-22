import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:micro_yelp/core/utils/width_and_height_converter.dart';
import 'package:micro_yelp/features/item/bloc/item_bloc.dart';
import 'package:micro_yelp/features/item/domain/related_items.dart';
import 'package:micro_yelp/features/item/presentation/widgets/loading.dart';
import 'package:micro_yelp/features/item/presentation/widgets/rating_card.dart';
import 'package:micro_yelp/features/item/presentation/widgets/star_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/constants.dart';

class RelatedItem extends StatelessWidget {
  List<RelatedItemModel> relatedItemModel;
  

   RelatedItem({
    required this.relatedItemModel
  });


  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    


    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: relatedItemModel.length,
      itemBuilder: (context, position) {
        String name = relatedItemModel[position].name;
        List<String> photos = relatedItemModel[position].photos;
        String averageRating = relatedItemModel[position].averageRating;
        String price = relatedItemModel[position].price;
        String id = relatedItemModel[position].id;
        double rating = double.parse(averageRating);
        int ratingfinal = rating.toInt();

        ImageProvider imag = AssetImage(MicroYelpImage.loginImage);
        if (photos.length > 0) {
          imag = NetworkImage(photos[0]);
        };
        // String name = 'Steasssssssssssssssssssssssssssssssssssk';
        if (name.length > 10) name = name.substring(0, 8) + '...';
        return GestureDetector(
          onTap: (){
            print("touched");
            BlocProvider.of<ItemBloc>(context)
                              .add(ItemLoadEvent(itemId:id));
          },
          child: Container(
            margin: EdgeInsets.only(
                right: widthCalculator(screenWidth: width, width: 20)),
            decoration: BoxDecoration(
              color: MicroYelpColor.cardColor,
              borderRadius: BorderRadius.circular(
                widthCalculator(
                  screenWidth: width,
                  width: 8,
                ),
              ),
            ),
            width: widthCalculator(screenWidth: width, width: 130),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Container(
                  height: heightCalculator(screenHeight: height, height: 90),
                  width: widthCalculator(screenWidth: width, width: 140),
                  decoration: BoxDecoration(
                    color: MicroYelpColor.cardColor,
                    image: DecorationImage(
                        image: imag,
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  )),
              SizedBox(
                height: heightCalculator(screenHeight: height, height: 5),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widthCalculator(screenWidth: width, width: 3),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    SizedBox(
                        width: widthCalculator(screenWidth: width, width: 60),
                        height:
                            heightCalculator(screenHeight: height, height: 10),
                        child: StarBar(
                            width: widthCalculator(screenWidth: width, width: 10),                          
                            numOfStars: ratingfinal)),
                            Padding(
                        padding: EdgeInsets.only(
                            right: widthCalculator(screenWidth: width, width: 8)),
                        child: Text(price, style: MicroYelpText.price),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(name, style: MicroYelpText.relatedName),
              
            ]),
          ),
        );
      },
    );
  }
}
