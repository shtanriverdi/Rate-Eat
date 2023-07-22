import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:micro_yelp/core/utils/utils_index.dart';

class ErrorPage extends StatelessWidget {
  final void Function()? onTap;
  const ErrorPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          MicroYelpImage.errorImage,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: heightCalculator(screenHeight: height, height: 30),
        ),
        Text(
          "Something went wrong",
          style: MicroYelpText.watermark,
        ),
        Text(
          "please try again!",
          style: MicroYelpText.watermark,
        ),
        SizedBox(
          height: heightCalculator(screenHeight: height, height: 30),
        ),
        GestureDetector(
          onTap: onTap == null ? () {} : onTap,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(
              Icons.refresh,
              color: MicroYelpColor.primaryColor,
            ),
            Text(
              "  Try Again",
              style: TextStyle(color: MicroYelpColor.primaryColor),
            )
          ]),
        )
      ],
    );
  }
}
