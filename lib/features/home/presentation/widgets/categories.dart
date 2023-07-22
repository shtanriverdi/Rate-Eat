import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_yelp/features/home/presentation/widgets/sub_categories.dart';
import '../../../../core/core.dart';
import '../../data/models/category_model.dart';
import 'package:micro_yelp/features/home/data/models/category_model.dart';
import '../bloc/home_bloc.dart';
import '../constants/static_states.dart';
import '../constants/list_of_icons.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: heightCalculator(screenHeight: height, height: 75),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCategories(context, index,
                  categories: HomePageStates.categories,
                  height: height,
                  width: width);
            },
            itemCount: HomePageStates.categories.length,
          ),
        ),
        SizedBox(height: height * 0.01),
        SubCategories(
          subCategories: HomePageStates.currentSubCategories,
        ),
      ],
    );
  }

  Widget buildCategories(BuildContext context, int index,
      {required List<Category> categories,
      required double height,
      required double width}) {
    return BlocBuilder<HomeBloc, ItemState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(width * 0.01),
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.03),
                )),
                elevation: MaterialStateProperty.all(0.5),
                backgroundColor:
                    (HomePageStates.currentSelectedHighLevelCategoryIndex ==
                            index)
                        ? MaterialStateProperty.all(Colors.orange)
                        : MaterialStateProperty.all(MicroYelpColor.inputField)),
            onPressed: (state is ItemNoLocationState ||
                    state is ItemLoadingState)
                ? null
                : () {
                    // Get the previous index
                    int prevIndex =
                        HomePageStates.currentSelectedHighLevelCategoryIndex;

                    // Update current selected high-level category index
                    HomePageStates.currentSelectedHighLevelCategoryIndex =
                        index;

                    // Clean up previous selected category item state
                    if (prevIndex != -1 && prevIndex != index) {
                      categories[prevIndex].categoryIcon =
                          disabledIcons[prevIndex];
                    }

                    // Update/Toggle the icons accordingly
                    categories[index].categoryIcon = enabledIcons[index];

                    // Add currently selected high-level category to the query
                    HomePageStates.selectedCategoryParameter = HomePageStates
                            .listOfHighLevelCategoryParameters[
                        HomePageStates.currentSelectedHighLevelCategoryIndex];

                    // Update current sub categories
                    HomePageStates.currentSubCategories = HomePageStates
                            .categoriesMap[
                        HomePageStates.currentSelectedHighLevelCategoryIndex]!;

                    // RESET THE STATE
                    // If we click the already enabled button, reset the state
                    if (prevIndex == index) {
                      toggleDisableCurrentSelectedHighLevelCategoryButton(
                          categories: categories, index: index);
                    }

                    // Update the UI for rebuilding the subcategories part
                    // or returning back to original/initial state
                    setState(() {});

                    // TODO
                    // If they choose any sub-category
                    // Remove currently selected high-level category to the query

                    // EDGE CASE TODO
                    // If they unselect all sub-categories,
                    // we should show the only selected high-level category again!

                    // Two needed parameters for "sort=" and "tags="
                    // updateSelectedCategoryParameter();

                    // Send an event to BLoC for categories and sorting
                    context.read<HomeBloc>().add(getTriggerEvent());
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                categories[index].categoryIcon,
                Text(categories[index].categoryName,
                    style: GoogleFonts.urbanist(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: (HomePageStates
                                  .currentSelectedHighLevelCategoryIndex ==
                              index)
                          ? Colors.white
                          : Colors.black45,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  // If we click the already enabled button, reset the state
  // Clean up the query, and currentSubCategories
  // Then close the sub category part.
  void toggleDisableCurrentSelectedHighLevelCategoryButton(
      {required int index, required List<Category> categories}) {
    // Revert back to initial state
    HomePageStates.currentSelectedHighLevelCategoryIndex = -1;

    // Add currently selected high-level category to the query
    HomePageStates.selectedCategoryParameter = "";

    // Update current sub categories
    HomePageStates.currentSubCategories = [];

    // Reset the icon
    categories[index].categoryIcon = disabledIcons[index];
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
