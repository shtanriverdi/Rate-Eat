import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:micro_yelp/core/utils/date_time_extension.dart';
import 'package:micro_yelp/core/utils/width_and_height_converter.dart';
import 'package:micro_yelp/features/authentication/authentication.dart';
import 'package:micro_yelp/features/authentication/data/repository/shared_preference.dart';
import 'package:micro_yelp/features/item/bloc/item_bloc.dart';
import 'package:micro_yelp/features/item/domain/edit_review.dart';
import 'package:micro_yelp/features/item/presentation/widgets/loading.dart';
import 'package:micro_yelp/features/item/presentation/widgets/rating_card.dart';

import 'package:micro_yelp/features/item/presentation/widgets/down_button_widget.dart';
import 'package:micro_yelp/features/item/presentation/widgets/up_button_widget.dart';
import 'package:micro_yelp/features/item/presentation/widgets/star_bar.dart';
import 'package:micro_yelp/features/item/presentation/update_review.dart';
import 'package:micro_yelp/features/profile/presentation/reviewer/widgets/image_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/presentation/widgets/star_rating_flexible.dart';
import '../../../../core/utils/constants.dart';

class ReviewCard1 extends StatelessWidget {
  final Function() upVoteFun;
  final Function() downVoteFun;
  final Function(EditReview editReview) onEdit;
  List<String> profilePic;
  String dateTime;
  int rating;
  String description;
  int upvote;
  int downvote;
  String name;
  String userId;
  List<String> imageList;
  String voted;
  String? sharedProfile;

  ReviewCard1(
      {required this.userId,
      required this.upVoteFun,
      required this.downVoteFun,
      required this.name,
      required this.profilePic,
      required this.dateTime,
      required this.rating,
      required this.description,
      required this.upvote,
      required this.downvote,
      required this.imageList,
      required this.onEdit,
      required this.voted,
      required this.sharedProfile});

  @override
  Widget build(BuildContext context) {
    ImageProvider imag = AssetImage(MicroYelpImage.userBackupImage);
    if (profilePic.length > 0) {
      imag = NetworkImage(profilePic[0]);
    }

    Color iconColor = MicroYelpColor.primaryColor;
    // String timestamp = DateTime.now().toString().substring(14, 16);
    // String timestampCreated = dateTime.toString().substring(14, 16);
    int timestampCreated1 = DateTime.parse(dateTime).millisecondsSinceEpoch;
    int datenow = DateTime.now().millisecondsSinceEpoch;
    int difference = datenow - timestampCreated1;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(
          bottom: heightCalculator(screenHeight: height, height: 31)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            widthCalculator(screenWidth: width, width: 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: imag,
            radius: widthCalculator(screenWidth: width, width: 20),
          ),
          SizedBox(
            width: widthCalculator(screenWidth: width, width: 8),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width*0.4,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: MicroYelpText.reviewProfile,
                          ),
                        ),
                        // SizedBox(
                        //   width: widthCalculator(screenWidth: width, width: 15),
                        // ),
                        StarRating(
                          allowHalfRating: false,
                          averageItemRating: rating.toDouble(),
                          ignoreGestures: true,
                          starSize:
                              widthCalculator(screenWidth: width, width: 25),
                        )
                      ],
                    ),
                    Container(
                        child: sharedProfile == userId
                            ? GestureDetector(
                                child: const Iconify(
                                  Carbon.edit,
                                  color: MicroYelpColor.iconColor,
                                ),
                                onTap: () async {
                                  final token = await StorageService.hasToken();

                                  if (datenow - timestampCreated1 <= 600000) {
                                    EditReview editReview =
                                        (await showModalBottomSheet<EditReview>(
                                      isScrollControlled: true,
                                      backgroundColor:
                                          MicroYelpColor.transparentColor,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UpdateReviewPage(
                                            previousText: description,
                                            previousRating: rating);
                                      },
                                    ))!;

                                    onEdit(editReview);
                                    // EditReview editReview =
                                    //     await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const UpdateReviewPage()),
                                    // );
                                    // onEdit(editReview);
                                    // onEdit();
                                  } else if (token == false) {
                                    Navigator.pushNamed(
                                        context, LoginPage.route);
                                  } else if (datenow - timestampCreated1 >
                                      600000) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          
                                            "you cann't edit after 10 min!",
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                    );
                                  }
                                },
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              )
                        //or any other widget but not null
                        ),
                  ],
                ),
                SizedBox(
                  height: heightCalculator(screenHeight: height, height: 2),
                ),
                Row(
                  children: [
                    Text(DateTime.parse(dateTime).timeAgo(numericDates: true), style: MicroYelpText.timeWatermark),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      dateTime.toString().substring(0, 10),
                      style: MicroYelpText.timeWatermark,
                    )
                  ],
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 20)),
                Text(
                  description,
                  style: MicroYelpText.reviewDiscription,
                ),
                const Divider(
                  color: Color.fromARGB(235, 212, 211, 211),
                  thickness: 0.9,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: MicroYelpColor.cardColor,
                          borderRadius: (BorderRadius.circular(5))),
                      child: Center(
                        child: UpVoteButton(
                          upVoteFun: upVoteFun,
                          isVoted: voted,
                          count: upvote,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 4),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 12),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: MicroYelpColor.cardColor,
                          borderRadius: (BorderRadius.circular(5))),
                      child: Center(
                        child: DownVoteButton(
                          downVoteFun: downVoteFun,
                          isVoted: voted,
                          count: downvote,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widthCalculator(screenWidth: width, width: 4),
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
                        itemCount: imageList.length,
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
                                        color: Colors.black.withOpacity(.7),
                                        height: height,
                                        width: width,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.2,
                                              left: width * 0.04,
                                              right: width * 0.04),
                                          child: Center(
                                            child: CarouselWithIndicatorDemo(
                                              photos: imageList,
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
                              margin: const EdgeInsets.all(5),
                              width: widthCalculator(
                                  screenWidth: width, width: 35),
                              height: widthCalculator(
                                  screenWidth: width, width: 45),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(imageList[index]),
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
