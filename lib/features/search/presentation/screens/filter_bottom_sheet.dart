import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/home/presentation/widgets/categories.dart';
import 'package:micro_yelp/features/search/data/models/search_model.dart';
import 'package:micro_yelp/features/search/presentation/bloc/bloc/distance_handler_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_event.dart';
import 'package:micro_yelp/features/search/presentation/widgets/bottom_sheet_controller.dart';
import 'package:micro_yelp/features/search/presentation/widgets/category_tag.dart';
import 'package:micro_yelp/features/search/presentation/widgets/high_level_category_tag.dart';
import 'package:micro_yelp/features/search/utils/helper.dart';

import '../bloc/categories_bloc_event_state.dart';

class FilterBottomSheet extends StatefulWidget {
  final SearchModel req;
  const FilterBottomSheet({Key? key, required this.req}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double bottomSheetHeight =
        widget.req.highLevelIndex == -1 ? height * 0.75 : height * 0.92;

    print(widget.req.highLevelIndex.toString() + " outside Main staff");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesBloc()
            ..add(UpdateCategories(highLevelIndex: widget.req.highLevelIndex)),
        ),
      ],
      child: SizedBox(
        height: bottomSheetHeight,
        child: Column(
          children: [
            Expanded(
                child: BottomSheetController(
                    givenHeight: bottomSheetHeight * 0.01)),
            BlocListener<CategoriesBloc, CategoriesState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is CategoriesUpdated) {
                  setState(() {
                    bottomSheetHeight = state.highLevelIndex == -1
                        ? height * 0.75
                        : height * 0.92;
                  });
                }
              },
              child: SizedBox(
                height: bottomSheetHeight * 0.015,
              ),
            ),
            Container(
              height: bottomSheetHeight * 0.975,
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.05),
                  topRight: Radius.circular(width * 0.05),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Apply Filters",
                      textAlign: TextAlign.center,
                      style: MicroYelpText.internalSubTitle,
                    ),
                  ),

                  // Categories
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: MicroYelpText.smallCardTitle,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      // Categories
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: height * 0.07,
                            child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: Helper.highLevelCategories.length,
                                itemBuilder: (BuildContext context, int ind) {
                                  var tagName = Helper.highLevelCategories[ind];
                                  return Row(
                                    children: [
                                      HighLevelCategoryTag(
                                        ind: ind,
                                        iconWidget: Helper.disabledIcons[ind],
                                        elevation: 2.0,
                                        tagName: tagName,
                                        req: widget.req,
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      )
                                    ],
                                  );
                                }),
                          );
                        },
                      ),

                      SizedBox(height: height * 0.01),

                      // Sub categories if any
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          return widget.req.highLevelIndex == -1
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sub categories",
                                      style: MicroYelpText.smallCardTitle,
                                    ),
                                    SizedBox(
                                      height: height * 0.024,
                                    ),
                                    Wrap(
                                      spacing: width * 0.02,
                                      runSpacing: height * 0.015,
                                      children: [
                                        for (var name in Helper.categoriesMap[
                                            Helper.highLevelCategories[
                                                widget.req.highLevelIndex]]!)
                                          CategoryTag(
                                            tagName: name,
                                            req: widget.req,
                                            isSelected: widget.req.subCategories
                                                .contains(name),
                                          ),
                                      ],
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<DistanceHandlerBloc, DistanceHandlerState>(
                    builder: (context, state) {
                      return locationStateWidget(
                          height: height,
                          info: "Enable your location",
                          state: state);
                    },
                  ),
                  // Price
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price (In ${widget.req.lowerBoundPrice} Birr - ${widget.req.higherBoundPrice} Birr range)",
                        style: MicroYelpText.smallCardTitle,
                      ),
                      RangeSlider(
                        values: RangeValues(widget.req.lowerBoundPrice,
                            widget.req.higherBoundPrice),
                        max: 1000,
                        divisions: 50,
                        labels: RangeLabels(
                            "${widget.req.lowerBoundPrice.round().toString()} Birr",
                            "${widget.req.higherBoundPrice.round().toString()} Birr"),
                        onChanged: (RangeValues values) {
                          setState(() {
                            widget.req.lowerBoundPrice = values.start;
                            widget.req.higherBoundPrice = values.end;
                          });
                        },
                      ),
                    ],
                  ),

                  // // Distance
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Distance (in ${widget.req.radius / 1000.toInt()} km radi)",
                  //       style: MicroYelpText.smallCardTitle,
                  //     ),
                  //     Slider(
                  //       value: widget.req.radius.toDouble(),
                  //       max: 100000,
                  //       divisions: 100,
                  //       label:
                  //           "${(widget.req.radius) / 1000.round().toInt()} km",
                  //       onChanged: (value) {
                  //         setState(() {
                  //           widget.req.radius = value.toInt();
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  // Rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating (${widget.req.lowerBoundAverageRating} and above)",
                        style: MicroYelpText.smallCardTitle,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      RatingBar.builder(
                        ignoreGestures: false,
                        initialRating: widget.req.lowerBoundAverageRating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glow: false,
                        unratedColor:
                            MicroYelpColor.greyBorder.withOpacity(0.8),
                        itemSize: width * 0.1,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: MicroYelpColor.starColor,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            widget.req.lowerBoundAverageRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),

                  // opening-hours
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Opening Hours (Time is in GMT+3)",
                        style: MicroYelpText.smallCardTitle,
                      ),
                      RangeSlider(
                        values: RangeValues(
                            double.parse(Helper.getIntegerFormat(
                                    widget.req.workingHour[0])
                                .toString()),
                            double.parse(Helper.getIntegerFormat(
                                    widget.req.workingHour[1])
                                .toString())),
                        min: 0,
                        max: 1439,
                        divisions: 96,
                        labels: RangeLabels(widget.req.workingHour[0],
                            widget.req.workingHour[1]),
                        onChanged: (RangeValues values) {
                          setState(() {
                            widget.req.workingHour[0] =
                                Helper.getTimeFormat(values.start.round());
                            widget.req.workingHour[1] =
                                Helper.getTimeFormat(values.end.round());
                          });
                        },
                      ),
                    ],
                  ),

                  RoundedButton(
                      buttonText: "Apply",
                      onClick: () {
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchSubmitted(req: widget.req));
                        Navigator.pop(context);
                      },
                      buttonColor: MicroYelpColor.primaryColor,
                      textStyle: MicroYelpText.buttonText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget distanceWidget() {
    // Distance
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Distance (in ${widget.req.radius / 1000.toInt()} km radi)",
          style: MicroYelpText.smallCardTitle,
        ),
        Slider(
          value: widget.req.radius.toDouble(),
          max: 100000,
          divisions: 100,
          label: "${(widget.req.radius) / 1000.round().toInt()} km",
          onChanged: (value) {
            setState(() {
              widget.req.radius = value.toInt();
            });
          },
        ),
      ],
    );
  }

  // Location related widget
  Widget locationStateWidget(
      {required double height,
      required String info,
      required DistanceHandlerState state}) {
    if (state is NoLocationState) {
      print("coming to inital or nolocation state");
      return Align(
        alignment: Alignment.center,
        child: showLocationDialog(
            height: height,
            info: "To filter by distance, enable location",
            state: state),
      );
    } else if (state is LocationEnabledState) {
      return distanceWidget();
    }
    print("passing every state");
    return const SizedBox.shrink();
  }

  Widget showLocationDialog(
      {required double height,
      required String info,
      required DistanceHandlerState state}) {
    return Column(children: [
      // SizedBox(
      //   height: height * 0.007,
      // ),
      ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.02),
            )),
            elevation: MaterialStateProperty.all(0.5),
            backgroundColor: MaterialStateProperty.all(Colors.orange.shade200)),
        onPressed: () async {
          if (state is NoLocationState) {
            Position position = await LocationService.determinePosition();
            bool hasPermissionGranted =
                await LocationService.hasLocationPermissionGranted();
            if (hasPermissionGranted == true) {
              updateCurrentUserLocation(position, widget.req);
              widget.req.near = "true";
              triggerLocationEnabledEvent();
            } else {
              triggerNoLocationEvent();
            }
          } else {
            triggerNoLocationEvent();
          }
        },
        child: Text(info),
      ),
    ]);
  }

  void triggerLocationEnabledEvent() {
    BlocProvider.of<DistanceHandlerBloc>(context).add(LocationEnabledEvent());
  }

  void triggerNoLocationEvent() {
    BlocProvider.of<DistanceHandlerBloc>(context).add(NoLocationEvent());
  }

  void updateCurrentUserLocation(Position position, SearchModel request) {
    request.latitude = position.latitude.toString();
    request.longitude = position.longitude.toString();
  }
}
