import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:location/location.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/home/presentation/widgets/search_no_result.dart';
import 'package:micro_yelp/features/search/data/models/search_model.dart';
import 'package:micro_yelp/features/search/presentation/bloc/bloc/distance_handler_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_event.dart';
import 'package:micro_yelp/features/search/presentation/screens/filter_bottom_sheet.dart';
import 'package:micro_yelp/features/search/presentation/widgets/search_result_cards.dart';
import 'package:micro_yelp/features/search/presentation/widgets/sort_by_row.dart';
import 'package:micro_yelp/features/search/presentation/widgets/sort_by_row.dart';

import '../../../home/presentation/widgets/error.dart';
import '../../utils/helper.dart';
import '../bloc/search_state.dart';

class SearchPage extends StatefulWidget {
  static const String route = "/searchpage";
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final req =
      SearchModel(name: "", categories: <String>{}, subCategories: <String>{});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DismissKeyboard(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: height * 0.94,
            // margin: EdgeInsets.only(top: height * 0.01),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.035),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  "Search",
                  style: MicroYelpText.titleOfPage,
                ),
                SizedBox(
                  height: height * 0.03,
                ),

                // search and filter row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: widthCalculator(
                            screenWidth: width * 1.1, width: 315),
                        height:
                            heightCalculator(screenHeight: height, height: 60),
                        decoration: BoxDecoration(
                            color: MicroYelpColor.inputField,
                            borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.03))),
                        child: Container(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              style: MicroYelpText.activitiesTitle,
                              controller: _searchFieldController,
                              cursorHeight: height * 0.03,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: MicroYelpText.smallCardTitle,
                                border: InputBorder.none,
                                focusColor: Colors.white,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (req.name.isNotEmpty) {
                                      BlocProvider.of<SearchBloc>(context)
                                          .add(SearchSubmitted(req: req));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MicroYelpColor.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(width * 0.03),
                                          bottomRight:
                                              Radius.circular(width * 0.03),
                                        )),
                                    height: heightCalculator(
                                        screenHeight: height, height: 60),
                                    width: width * 0.05,
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                req.name = value;
                              },
                              onFieldSubmitted: (val) {
                                if (req.name.isNotEmpty) {
                                  BlocProvider.of<SearchBloc>(context)
                                      .add(SearchSubmitted(req: req));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            widthCalculator(screenWidth: width, width: 55),
                            widthCalculator(screenWidth: width, width: 55)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                        elevation: 0.5,
                        primary: MicroYelpColor.primaryColor,
                      ),

                      // trigger bottom sheet filter
                      onPressed: () async {
                        // bool hasLocationRequestSucceeded =
                        //     await LocationService.hasLocationRequestSucceeded();

                        // if (hasLocationRequestSucceeded == true) {
                        //   Position position =
                        //       await LocationService.determinePosition();

                        //   bool hasPermissionGranted = await LocationService
                        //       .hasLocationPermissionGranted();
                        //   if (hasPermissionGranted == true) {
                        //     updateCurrentUserLocation(position, req);
                        //     triggerLocationEnabledEvent();
                        //   } else {
                        //     triggerNoLocationEvent();
                        //   }
                        // } else {
                        //   triggerNoLocationEvent();
                        // }
                        bool locationEnabled =
                            await LocationService.isLocationEnabled();
                        bool permissionGranted = await LocationService
                            .hasLocationPermissionGranted();
                        print(
                            "locations enabled: $locationEnabled, permission granted: $permissionGranted");
                        if (locationEnabled && permissionGranted) {
                          LocationData location =
                              await Location().getLocation();
                          updateCurrentUserLocation(location, req);
                          req.near = "true";
                          triggerLocationEnabledEvent();
                        } else {
                          triggerNoLocationEvent();
                        }

                        if (req.workingHour[0].isEmpty) {
                          String time = Helper.getGlobalTime();
                          var now = Helper.getTimeFromTimeZone(time.trim(), 0);
                          var nowPlus1 =
                              Helper.getTimeFromTimeZone(time.trim(), 1);
                          req.workingHour = [now, nowPlus1];
                        }
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: MicroYelpColor.transparentColor,
                          context: context,
                          builder: (BuildContext context) {
                            return FilterBottomSheet(req: req);
                          },
                        );
                      },
                      child: const Iconify(
                        Majesticons.adjustments_line,
                        color: MicroYelpColor.appBarBackgroundColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),

                // Items label and sorting
                Expanded(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Items",
                            style: MicroYelpText.internalSubTitle,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.5),
                              ),
                              color: MicroYelpColor.primaryColor,
                            ),
                            height: height * 0.004,
                            width: width * 0.08,
                          ),
                        ],
                      ),
                      // const Expanded(child: SizedBox()),
                      SortByRow(req: req),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    Widget listContent = Container();
                    if (state is SearchResultLoaded) {
                      var items = state.items;
                      if (items.isEmpty) {
                        listContent = ListView(children: const [NoResult()]);
                      } else {
                        listContent = ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = items[index];
                              return SearchResultCard(
                                id: item.id,
                                title: item.name,
                                imageUrl: item.picture[0],
                                price: item.price,
                                description: item.description,
                                averageRating: item.ratingAverage,
                                address: item.address,
                                restaurantName: item.restaurantName,
                                numOfReviews: item.numOfReviews.toString(),
                              );
                            });
                      }
                    } else if (state is SearchResultLoading) {
                      listContent =
                          const Center(child: CircularProgressIndicator());
                    } else if (state is SearchResultError) {
                      listContent = Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: ErrorPage(onTap: () {
                          BlocProvider.of<SearchBloc>(context).add(
                            SearchSubmitted(req: req),
                          );
                        }),
                        // child: Text(state.error),
                      );
                    }
                    return Expanded(
                      child: Container(
                          // margin: EdgeInsets.only(bottom: height * 0.1),
                          child: returnRefreshIndicator(context, listContent)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateCurrentUserLocation(LocationData location, SearchModel request) {
    request.latitude = location.latitude.toString();
    request.longitude = location.longitude.toString();
  }

// Send no location event to the BLoC
  void triggerNoLocationEvent() {
    context.read<DistanceHandlerBloc>().add(NoLocationEvent());
  }

  void triggerLocationEnabledEvent() {
    context.read<DistanceHandlerBloc>().add(LocationEnabledEvent());
  }

  Widget returnRefreshIndicator(
    BuildContext context,
    Widget child,
  ) {
    return RefreshIndicator(
      edgeOffset: 10,
      onRefresh: () async {
        BlocProvider.of<SearchBloc>(context).add(
          SearchSubmitted(req: req),
        );
      },
      child: child,
    );
  }
}
