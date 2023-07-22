import 'package:flutter/material.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/home/presentation/constants/static_states.dart';

class SearchIcon extends StatelessWidget {
  final double height;
  final double width;
  final double realWidth;

  const SearchIcon({
    Key? key,
    required this.height,
    required this.width,
    required this.realWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  widthCalculator(screenWidth: realWidth, width: 10)),
            )),
            elevation: MaterialStateProperty.all(0.5),
            backgroundColor:
                MaterialStateProperty.all(MicroYelpColor.primaryColor)),
        onPressed: () {
          final BottomNavigationBar navigationBar =
              HomePageStates.globalKey.currentWidget as BottomNavigationBar;
          navigationBar.onTap!(1);
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: widthCalculator(screenWidth: realWidth, width: 30),
        ),
      ),
    );
  }
}
