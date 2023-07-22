import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';

class BottomSheetController extends StatelessWidget {
  final double givenHeight;
  const BottomSheetController({Key? key, required this.givenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(width * 0.4),
        ),
        color: MicroYelpColor.greyBorder,
      ),
      height: givenHeight * 0.01,
      width: width * 0.12,
    );
  }
}
