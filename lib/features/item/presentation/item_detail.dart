import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:micro_yelp/features/authentication/authentication.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/item/bloc/item_bloc.dart';
import 'package:micro_yelp/features/item/domain/vote.dart';
import '../../restaurant/restaurant.dart';
import 'package:micro_yelp/features/review/review.dart';
import 'item_detail.dart';
import 'widgets/item_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/core.dart';

class ItemDetail extends StatefulWidget {
  static const String route = "/item_detail";
  const ItemDetail({super.key});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Map<String, String> filters = <String, String>{
    'Recent': 'Recent',
    'Most UpVoted': 'Most UpVoted'
  };
  String? dropdownvalue = 'Recent';

  @override
  Widget build(BuildContext context) {
    int activeindex = 0;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if (state is ItemLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            // BlocProvider.of<ItemBloc>(context).add(const ItemLoadEvent());
            return Scaffold(
              body: Loading(),
            );
          } else if (state is ItemLoadSuccess) {
            List<int> ans = [];
            List images = state.item!.photos;
            int la = state.item!.photos.length;
            for (int i = 0; i < la; i += 1) {
              ans.add(i);
            }

            String averageRating = state.item!.averageRating;
            if (state.item!.averageRating.length > 3) {
              averageRating = state.item!.averageRating.substring(0, 3);
            }
            return Scaffold(
              body: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(children: [
                                  Iconify(
                                    Ic.baseline_arrow_back_ios_new,
                                    size: width * 0.03,
                                  ),
                                  SizedBox(
                                    width: widthCalculator(
                                        screenWidth: width, width: 5),
                                  ),
                                  Text("Back", style: MicroYelpText.back),
                                ]),
                              ),
                              SizedBox(
                                width: widthCalculator(
                                    screenWidth: width, width: 41),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: heightCalculator(
                                  screenHeight: height, height: 10),
                              horizontal: widthCalculator(
                                  screenWidth: width, width: 20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CrouselSliderAnimation(
                                  ans: ans,
                                  images: images,
                                  height: height,
                                  width: width),
                              //
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 20),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<RestaurantBloc>(context)
                                          .add(LoadRestaurantInfo(
                                              id: state.item!.companyOwner.id));
                                      Navigator.pushNamed(
                                          context, RestaurantDetail.route);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.33,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            state.item!.companyOwner.entityName,
                                            style: MicroYelpText.detailRestText,
                                            maxLines: 2,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_right,
                                          color: Color(0xFF4464B5),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${state.item!.price} birr",
                                    style: MicroYelpText.price,
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${state.item!.name}",
                                        style: MicroYelpText.internalSubTitle,
                                        maxLines: 3,
                                      ),
                                    ),
                                    Row(children: [
                                      const Star(
                                          size: 20,
                                          color: MicroYelpColor.primaryColor),
                                      Text(
                                        "${averageRating} ",
                                        style: MicroYelpText.smallCardTitle,
                                      ),
                                      Text(
                                        " (${state.item!.reviews.length} Reviews)",
                                        style: MicroYelpText.watermark,
                                      ),
                                    ]),
                                  ]),
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 35),
                              ),
                              RatingCard(
                                  one: state.item!.rating["1"],
                                  two: state.item!.rating["2"],
                                  three: state.item!.rating["3"],
                                  four: state.item!.rating["4"],
                                  five: state.item!.rating["5"],
                                  averageRating: averageRating,
                                  numberOfReviews: state.item!.numberOfReviews),
                              // one: state.item!.rating["1"], two: state.item!.rating["2"], three: state.item!.rating["3"], four: state.item!.rating["4"], five: state.item!.rating["5"], averageRating: state.item!.averageRating, numberOfReviews: state.item!.numberOfReviews
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 20),
                              ),
                              Text("Description",
                                  style: MicroYelpText.internalSubTitle),
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 10),
                              ),
                              Text(state.item!.description,
                                  style: MicroYelpText.profile),
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 20),
                              ),
                              Text("Related",
                                  style: MicroYelpText.internalSubTitle),
                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 12),
                              ),
                              // SizedBox(
                              //   height: heightCalculator(screenHeight: height, height: 150),
                              //   child: RelatedItem(),
                              // ),
                              Container(
                                child: !state.item!.related_items.isEmpty
                                    ? SizedBox(
                                        height: heightCalculator(
                                            screenHeight: height, height: 150),
                                        child: RelatedItem(
                                            relatedItemModel:
                                                state.item!.related_items),
                                      )
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                              ),

                              SizedBox(
                                height: heightCalculator(
                                    screenHeight: height, height: 30),
                              ),
                              Divider(),
                              GestureDetector(
                                  child: Row(
                                    children: [
                                      const Iconify(
                                        Uil.comment_plus,
                                        color: MicroYelpColor.primaryColor,
                                      ),

                                      SizedBox(
                                        width: widthCalculator(
                                            screenWidth: width, width: 10),
                                      ), // widget
                                      Text(
                                        'Add Review',
                                        style: MicroYelpText.addReviewMicroYelp,
                                      ),
                                      SizedBox(
                                        width: widthCalculator(
                                            screenWidth: width, width: 5),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    final token =
                                        await StorageService.getToken();
                                    final bool isLoggedIn = !(token == null);
                                    if (isLoggedIn) {
                                      var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddReview(
                                                    description:
                                                        state.item!.description,
                                                    imageProvider: NetworkImage(
                                                        state.item!.photos[0]),
                                                    itemId: state.item!.id,
                                                    name: state.item!.name,
                                                  )));
                                      BlocProvider.of<ItemBloc>(context).add(
                                          ItemLoadEvent(
                                              itemId: state.item!.id));
                                    } else {
                                      Navigator.pushNamed(
                                          context, LoginPage.route);
                                    } //
                                  }),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'User Reviews',
                                    style: MicroYelpText.internalSubTitle,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(widthCalculator(
                                        screenWidth: width, width: 13)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        elevation: 3,
                                        underline: Divider(
                                            thickness: 2, color: Colors.red),
                                        borderRadius: BorderRadius.circular(
                                            widthCalculator(
                                                screenWidth: width, width: 7)),
                                        // Initial Value
                                        value: dropdownvalue,
                                        selectedItemBuilder: (context) =>
                                            filters.values
                                                .map<Widget>((String item) {
                                          return Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("$item  ",
                                                style: MicroYelpText.selected),
                                          );
                                        }).toList(),

                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: filters.keys
                                            .map<DropdownMenuItem<String>>(
                                                (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: MicroYelpText.profile),
                                          );
                                        }).toList(),

                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                          });

                                          if (dropdownvalue == "Most UpVoted") {
                                            BlocProvider.of<ItemBloc>(context)
                                                .add(SortItemEvent(
                                                    item: state.item!,
                                                    itemId:
                                                        "${state.item!.id}?upvote=1"));
                                          } else if (dropdownvalue ==
                                              "Recent") {
                                            BlocProvider.of<ItemBloc>(context)
                                                .add(SortItemEvent(
                                                    item: state.item!,
                                                    itemId:
                                                        "${state.item!.id}?date=1"));
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: heightCalculator(
                                  screenHeight: height, height: 10),
                              horizontal: widthCalculator(
                                  screenWidth: width, width: 20)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.item!.reviews.length,
                            itemBuilder: ((context, index) {
                              // todo use shared preference

                              Vote vote = Vote(
                                  reviewId: state.item!.reviews[index].id,
                                  itemId: state.item!.id);

                              return ReviewCard1(
                                voted: state.item!.reviews[index].voted,
                                sharedProfile: state.userId!,

                                userId: state
                                    .item!.reviews[index].reviewerProfile.id,
                                onEdit: (result) {
                                  BlocProvider.of<ItemBloc>(context).add(
                                    UpdateReviewEvent(
                                      editReview: result,
                                      reviewId: state.item!.reviews[index].id,
                                      itemId: state.item!.id,
                                      item: state.item!,
                                    ),
                                  );
                                },

                                upVoteFun: () {
                                  BlocProvider.of<ItemBloc>(context).add(
                                    UpVoteEvent(vote: vote, item: state.item!),
                                  );
                                },

                                downVoteFun: () {
                                  BlocProvider.of<ItemBloc>(context).add(
                                      DownVoteEvent(
                                          vote: vote, item: state.item!));
                                },
                                // id: "${state.item.reviews[index].reviewerProfile.id}
                                name:
                                    "${state.item!.reviews[index].reviewerProfile.firstName} ${state.item!.reviews[index].reviewerProfile.lastName}",
                                downvote: int.parse(
                                    state.item!.reviews[index].downVotes),
                                upvote: int.parse(
                                    state.item!.reviews[index].upVotes),
                                description:
                                    "${state.item!.reviews[index].textFeedback}",
                                rating: int.parse(
                                    state.item!.reviews[index].rating),
                                profilePic: state.item!.reviews[index]
                                    .reviewerProfile.photos,
                                dateTime: state.item!.reviews[index].createdAt,
                                imageList: state.item!.reviews[index].photos,
                                // itemBloc: ItemBloc(),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ItemLoadFailure) {
            return Scaffold(
              body: SafeArea(
                child: Container(),
              ),
            );
          }
          return Scaffold(
              body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: const Text("No Result"),
            ),
          ));
        },
      ),
    );
  }
}

class CrouselSliderAnimation extends StatefulWidget {
  const CrouselSliderAnimation({
    Key? key,
    required this.ans,
    required this.height,
    required this.width,
    required this.images,
  }) : super(key: key);

  final List<int> ans;
  final double height;
  final double width;
  final List<dynamic> images;

  @override
  State<CrouselSliderAnimation> createState() => _CrouselSliderAnimationState();
}

class _CrouselSliderAnimationState extends State<CrouselSliderAnimation> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: heightCalculator(screenHeight: widget.height, height: 400),
          width: widthCalculator(screenWidth: widget.width, width: 400),
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: ((index, reason) {
                setState(() {
                  activeIndex = index;
                });
              }),
              height:
                  heightCalculator(screenHeight: widget.height, height: 400),
            ),
            items: widget.ans.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: widthCalculator(
                            screenWidth: widget.width, width: 10)),
                    width:
                        widthCalculator(screenWidth: widget.width, width: 400),
                    height: heightCalculator(
                        screenHeight: widget.height, height: 400),
                    decoration: const BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(15)),
                      color: MicroYelpColor.primaryColor,
                    ),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.images[i]),
                                fit: BoxFit.cover),
                          ),
                        )),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: heightCalculator(screenHeight: widget.height, height: 10),
        ),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.images.length,
            effect: const ExpandingDotsEffect(
              dotWidth: 7,
              dotHeight: 7,
              activeDotColor: MicroYelpColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
