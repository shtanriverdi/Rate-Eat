import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import '../../../../../core/core.dart';
import 'image_slider.dart';

class ReviewCard extends StatelessWidget {
  ImageProvider profilePic;
  DateTime dateTime;
  int rating;
  String description;
  int upvote;
  int downvote;
  String name;
  List<String> itemPhotos;
  String voted;

  ReviewCard({
    required this.name,
    required this.profilePic,
    required this.dateTime,
    required this.rating,
    required this.description,
    required this.upvote,
    required this.downvote,
    required this.itemPhotos,
    required this.voted,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            widthCalculator(screenWidth: width, width: 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: profilePic,
            radius: widthCalculator(screenWidth: width, width: 30),
          ),
          SizedBox(
            width: widthCalculator(screenWidth: width, width: 8),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: MicroYelpText.profile,
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 35),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 90),
                      height:
                          heightCalculator(screenHeight: height, height: 15),
                      child: StarRating(
                        allowHalfRating: false,
                        averageItemRating: rating.toDouble(),
                        ignoreGestures: true,
                        starSize:
                            widthCalculator(screenWidth: width, width: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: widthCalculator(screenWidth: width, width: 9),
                ),
                Row(
                  children: [
                    Text(
                      "8 hrs ago",
                      style: MicroYelpText.watermark,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      dateTime.toString().substring(0, 10),
                      style: MicroYelpText.watermark,
                    )
                  ],
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 20)),
                Text(
                  description,
                  style: MicroYelpText.watermark,
                ),
                const Divider(
                  color: Color.fromARGB(235, 212, 211, 211),
                  thickness: 0.9,
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        height: widthCalculator(screenWidth: width, width: 32),
                        width: widthCalculator(screenWidth: width, width: 32),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MicroYelpColor.cardColor,
                              borderRadius: (BorderRadius.circular(5))),
                          child: Center(
                            child: Iconify(
                              Fluent.triangle_32_filled,
                              color: voted == '1'
                                  ? MicroYelpColor.primaryColor
                                  : MicroYelpColor.bottomNavigationIconColor,
                              size: width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // upVoteFun();
                      },
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      upvote.toString(),
                      style: const TextStyle(
                          fontSize: 20, color: MicroYelpColor.greyBorder),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    GestureDetector(
                      child: SizedBox(
                        height: widthCalculator(screenWidth: width, width: 32),
                        width: widthCalculator(screenWidth: width, width: 32),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MicroYelpColor.cardColor,
                              borderRadius: (BorderRadius.circular(5))),
                          child: Center(
                            child: Iconify(
                              Pepicons.triangle_down_filled,
                              color: voted == '-1'
                                  ? MicroYelpColor.primaryColor
                                  : MicroYelpColor.bottomNavigationIconColor,
                              size: width * 0.08,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        // upVoteFun();
                      },
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      downvote.toString(),
                      style: const TextStyle(
                          fontSize: 20, color: MicroYelpColor.greyBorder),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 10),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 110),
                      height:
                          heightCalculator(screenHeight: height, height: 40),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: itemPhotos.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  content: Builder(builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.black.withOpacity(.6),
                                        height: height,
                                        width: width,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.2,
                                              left: width * 0.04,
                                              right: width * 0.04),
                                          child: Center(
                                            child: CarouselWithIndicatorDemo(
                                              photos: itemPhotos,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              width: widthCalculator(
                                  screenWidth: width, width: 45),
                              height: widthCalculator(
                                  screenWidth: width, width: 45),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(itemPhotos[index]),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
