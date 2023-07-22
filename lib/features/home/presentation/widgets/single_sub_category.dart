import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/home/presentation/constants/static_states.dart';
import '../bloc/home_bloc.dart';

class SubCategory extends StatefulWidget {
  final String subCategoryName;
  final int index;
  bool isSelected;

  SubCategory({
    Key? key,
    required this.subCategoryName,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.006, horizontal: width * 0.06),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          color: widget.isSelected ? Colors.orange : MicroYelpColor.inputField,
        ),
        child: Text(
          widget.subCategoryName,
          style: MicroYelpText.tagStyle(widget.isSelected),
        ),
      ),
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        if (widget.isSelected) {
          // If selectedSubCategoryIndicesSet is empty
          // Remove the currently selected high-level category from the query
          if (HomePageStates.selectedSubCategoryIndicesSet.isEmpty) {
            HomePageStates.selectedCategoryParameter = "";
          }
          // Add currently selected sub-category to selectedSubCategoryIndicesSet
          HomePageStates.selectedSubCategoryIndicesSet.add(widget.index);
        } else {
          // Remove currently unselected sub-category to selectedSubCategoryIndicesSet
          HomePageStates.selectedSubCategoryIndicesSet.remove(widget.index);

          // If selectedSubCategoryIndicesSet is empty
          // Remove the currently selected high-level category from the query
          if (HomePageStates.selectedSubCategoryIndicesSet.isEmpty) {
            // Add currently selected high-level category to the query
            HomePageStates.selectedCategoryParameter =
                HomePageStates.listOfHighLevelCategoryParameters[
                    HomePageStates.currentSelectedHighLevelCategoryIndex];
          }
        }

        // Update selectedSubCategoryParameters if selectedSubCategoryIndicesSet is not empty
        if (HomePageStates.selectedSubCategoryIndicesSet.isNotEmpty) {
          updateSelectedSubCategoryParameters();
        }

        // Send an event to BLoC for categories and sorting
        context.read<HomeBloc>().add(getTriggerEvent());
      },
    );
  }

  // Update selectedSubCategoryParameters
  void updateSelectedSubCategoryParameters() {
    List<String> subCategoryList = HomePageStates
        .categoriesMap[HomePageStates.currentSelectedHighLevelCategoryIndex]!;

    List<String> selectedSubCategoryStrings = [];
    for (var selectedselectedSubCategoryIndex in HomePageStates.selectedSubCategoryIndicesSet) {
      selectedSubCategoryStrings.add(subCategoryList[selectedselectedSubCategoryIndex]);
    }

    HomePageStates.selectedCategoryParameter =
        selectedSubCategoryStrings.join(",");
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
