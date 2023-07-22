import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';

class SearchBar extends StatelessWidget {
  final double height;
  final double width;

  const SearchBar({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = TextEditingController();
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: searchBarController,
        decoration: InputDecoration(
            filled: true,
            fillColor: MicroYelpColor.inputField,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: width * 0.03, end: width * 0.03),
              child: const Icon(Icons.search),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MicroYelpColor.primaryColor,
                width: widthCalculator(
                    figmaWidth: 480, screenWidth: width, width: 1),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widthCalculator(screenWidth: width, width: 10),
                ),
              ),
            ),
            hintText: "Search",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widthCalculator(screenWidth: width, width: 10),
                ),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle: MicroYelpText.profile),
      ),
    );
  }
}
