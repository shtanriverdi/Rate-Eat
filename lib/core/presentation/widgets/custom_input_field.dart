import 'package:flutter/material.dart';
import '../../utils/width_and_height_converter.dart';
import '../../utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon icon;
  final double customHeight;
  final double customWidth;
  final TextStyle textStyle;

  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.customHeight,
      required this.customWidth,
      required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Container(
      width: widthCalculator(
          figmaWidth: 480, screenWidth: width, width: customWidth),
      height: heightCalculator(
          figmaHeight: 926, screenHeight: height, height: customHeight),
      decoration: BoxDecoration(
        color: MicroYelpColor.inputField,
        borderRadius: BorderRadius.all(
          Radius.circular(
            width * 0.03,
          ),
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: icon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: widthCalculator(
                    figmaWidth: 480, screenWidth: width, width: 1.2),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(width * 0.035),
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(width * 0.0348),
            hintText: hintText,
            hintStyle: textStyle),
      ),
    );
  }
}
