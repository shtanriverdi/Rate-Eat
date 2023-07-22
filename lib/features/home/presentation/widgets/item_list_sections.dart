import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/core.dart';
import '../bloc/home_bloc.dart';
import '../constants/static_states.dart';

class ItemListSections extends StatefulWidget {
  const ItemListSections({Key? key}) : super(key: key);

  @override
  State<ItemListSections> createState() => _ItemListSectionsState();
}

class _ItemListSectionsState extends State<ItemListSections> {
  Map<int, String> sortByMap = {
    // Affordable
    // Price in ascending order
    0: "price",
    // Nearby
    1: "",
    // Top Rated
    // ratingAverage in descending order
    2: "-ratingAverage",
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        height: heightCalculator(screenHeight: height, height: 30),
        child: BlocBuilder<HomeBloc, ItemState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          widthCalculator(screenWidth: width, width: 55),
                          widthCalculator(screenWidth: width, width: 55))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: state is ItemLoadingState
                        ? null
                        : () {
                            setStateForSection(0);
                            clearLocationInfo();
                            triggerEvent();
                          },
                    child: setTextColor("Affordable", 0)),
                // Nearby Section
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          widthCalculator(screenWidth: width, width: 55),
                          widthCalculator(screenWidth: width, width: 55))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: state is ItemLoadingState
                        ? null
                        : () async {
                            setStateForSection(1);

                            bool hasLocationRequestSucceeded =
                                await LocationService
                                    .hasLocationRequestSucceeded();

                            if (hasLocationRequestSucceeded == true) {
                              Position position =
                                  await LocationService.determinePosition();

                              bool hasPermissionGranted = await LocationService.hasLocationPermissionGranted();
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
                    child: setTextColor("Nearby", 1)),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          widthCalculator(screenWidth: width, width: 55),
                          widthCalculator(screenWidth: width, width: 55))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: state is ItemLoadingState
                        ? null
                        : () {
                            setStateForSection(2);
                            clearLocationInfo();
                            triggerEvent();
                          },
                    child: setTextColor("Top Rated", 2)),
              ],
            );
          },
        ));
  }

  void clearLocationInfo() {
    HomePageStates.latitude = '';
    HomePageStates.longitude = '';
  }

  void getSelectedSortByParameter(int index) {
    // Sorting Queries
    // To Get Affordable(By price in ascending order):
    // "sort=price"
    // To Get Top Rated(By averageRating in descending order):
    // "sort=-avgRating"
    // To Get Nearby(By price in ascending order):
    // sort= ???(Backend is working on it)
    HomePageStates.sortBy = sortByMap[index]!;
  }

  void updateCurrentUserLocation(Position position) {
    HomePageStates.latitude = position.latitude.toString();
    HomePageStates.longitude = position.longitude.toString();
  }

  void setStateForSection(int index) {
    HomePageStates.isSelected = [false, false, false];
    HomePageStates.isSelected[index] = !HomePageStates.isSelected[index];
    getSelectedSortByParameter(index);
    HomePageStates.selectedSectionIndex = index;
    setState(() {});
  }

  // Send success event to the BLoC
  void triggerEvent() {
    context.read<HomeBloc>().add(GetAllItemsEvent(
        selectedCategoryParameter: HomePageStates.selectedCategoryParameter,
        sortBy: HomePageStates.sortBy,
        isFasting: HomePageStates.isFasting,
        latitude: HomePageStates.latitude,
        longitude: HomePageStates.longitude));
  }

  // Send no location event to the BLoC
  void triggerNoLocationEvent() {
    context.read<HomeBloc>().add(NoLocationEvent());
  }

  Widget setTextColor(String sectionName, int index) {
    return Text(sectionName,
        style: TextStyle(
            fontFamily: MicroYelpText.mainTitle.fontFamily,
            color: HomePageStates.isSelected[index] ? Colors.orange : Colors.black));
  }
}
