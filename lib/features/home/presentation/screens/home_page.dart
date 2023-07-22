import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/core.dart';
import '../../data/models/item_model.dart';
import '../bloc/home_bloc.dart';
import '../constants/static_states.dart';
import '../widgets/fasting_button.dart';
import '../widgets/widgets_index.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homepage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "Home";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: DismissKeyboard(
        child: Scaffold(
          backgroundColor: MicroYelpColor.appBarBackgroundColor,
          appBar: appBar(context,
              height: height, title: userName, width: width * 1.5),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 24,
                      child: SearchBar(
                        height:
                            heightCalculator(screenHeight: height, height: 68),
                        width: width,
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: SizedBox.shrink(),
                    ),
                    SearchIcon(
                      height:
                          heightCalculator(screenHeight: height, height: 68),
                      width: heightCalculator(screenHeight: height, height: 68),
                      realWidth: width,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Text(
                        "Categories",
                        textAlign: TextAlign.left,
                        style: MicroYelpText.categoriesTitle,
                      ),
                    ),
                    const FastingButton(),
                  ],
                ),
                SizedBox(height: height * 0.012),
                const Categories(),
                const ItemListSections(),
                SizedBox(height: height * 0.01),
                Flexible(
                  flex: 1,
                  child: BlocBuilder<HomeBloc, ItemState>(
                    builder: (context, state) {
                      if (state is ItemInitialState) {
                        triggerEvent();
                      } else if (state is ItemLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        );
                      } else if (state is ItemSuccessState) {
                        Widget successStateWidget = getGridViewBuilder(
                            state.items,
                            height: height,
                            width: width);
                        return returnRefreshIndicator(
                            event: getTriggerEvent(),
                            context,
                            successStateWidget,
                            height: height,
                            width: width);
                      }
                      // If location is not enabled
                      else if (state is ItemNoLocationState) {
                        return locationStateWidget(
                            height: height,
                            info: "Please Enable Your Location!",
                            state: state);
                      } else if (state is ItemErrorState) {
                        Widget connectionErrorStateWidget = getErrorStateWidget(
                            isNoLocationState: false,
                            height: height,
                            info: "Connection Error!");
                        return returnRefreshIndicator(
                            event: getTriggerEvent(),
                            context,
                            connectionErrorStateWidget,
                            height: height,
                            width: width);
                      }
                      return const Center(child: Text('Unknown Error!'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget returnRefreshIndicator(BuildContext context, Widget child,
      {required double height,
      required double width,
      required ItemEvent event}) {
    return RefreshIndicator(
        onRefresh: () async {
          // If we choose Nearby section, check if location is enabled
          bool isLocationEnabled = await LocationService.isLocationEnabled();
          if (HomePageStates.selectedSectionIndex == 1) {
            if (isLocationEnabled) {
              triggerEvent();
            } else {
              triggerNoLocationEvent();
            }
          } else {
            triggerEvent();
          }
        },
        child: child);
  }

  // Location related widget
  Widget locationStateWidget(
      {required double height,
      required String info,
      required ItemState state}) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: heightCalculator(height: 220, screenHeight: height),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(info),
        ),
        (state is ItemNoLocationState)
            ? Align(
                alignment: Alignment.center,
                child: showLocationDialog(
                    height: height, info: "Enable Location", state: state),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget showLocationDialog(
      {required double height,
      required String info,
      required ItemState state}) {
    return Column(children: [
      SizedBox(
        height: height * 0.03,
      ),
      ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.02),
            )),
            elevation: MaterialStateProperty.all(0.5),
            backgroundColor: MaterialStateProperty.all(Colors.orange.shade200)),
        onPressed: () async {
          if (state is ItemNoLocationState) {
            Position position = await LocationService.determinePosition();
            bool hasPermissionGranted =
                await LocationService.hasLocationPermissionGranted();
            if (hasPermissionGranted == true) {
              updateCurrentUserLocation(position);
              triggerEvent();
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

  Widget getErrorStateWidget(
      {required double height,
      required String info,
      required bool isNoLocationState}) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: heightCalculator(height: 220, screenHeight: height),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: isNoLocationState
              ? const Icon(Icons.location_on)
              : const Icon(Icons.error_outline),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(info),
        ),
      ],
    );
  }

  Widget getGridViewBuilder(List<Item> items,
      {required double height, required double width}) {
    if (items.isNotEmpty) {
      return GridView.builder(
          padding: EdgeInsets.only(bottom: width * 0.03),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: width * 0.59,
              maxCrossAxisExtent: width * 0.56,
              crossAxisSpacing: width * 0.012,
              mainAxisSpacing: height * 0.01),
          itemCount: items.length,
          itemBuilder: (BuildContext context, index) {
            return buildTopRatedItems(context, index,
                topRatedItems: items, height: height, width: width);
          });
    }
    return getErrorStateWidget(
        isNoLocationState: false,
        height: height,
        info: "There is nothing to show!");
  }

  Widget buildTopRatedItems(BuildContext context, int index,
      {required List<Item> topRatedItems,
      required double height,
      required double width}) {
    return ItemCard(
      itemId: topRatedItems[index].id,
      itemTitle: topRatedItems[index].name,
      restaurantName: topRatedItems[index].restaurantName,
      imageUrl: topRatedItems[index].picture[0],
      averageItemRating: topRatedItems[index].ratingAverage,
      price: topRatedItems[index].price.toString(),
    );
  }

  // Send no location event to the BLoC
  void triggerNoLocationEvent() {
    context.read<HomeBloc>().add(NoLocationEvent());
  }

  void triggerEvent() {
    context.read<HomeBloc>().add(GetAllItemsEvent(
        selectedCategoryParameter: HomePageStates.selectedCategoryParameter,
        sortBy: HomePageStates.sortBy,
        isFasting: HomePageStates.isFasting,
        latitude: HomePageStates.latitude,
        longitude: HomePageStates.longitude));
  }

  void updateCurrentUserLocation(Position position) {
    HomePageStates.latitude = position.latitude.toString();
    HomePageStates.longitude = position.longitude.toString();
  }

  GetAllItemsEvent getTriggerEvent() {
    return GetAllItemsEvent(
        selectedCategoryParameter: HomePageStates.selectedCategoryParameter,
        sortBy: HomePageStates.sortBy,
        isFasting: HomePageStates.isFasting,
        latitude: HomePageStates.latitude,
        longitude: HomePageStates.longitude);
  }
}
