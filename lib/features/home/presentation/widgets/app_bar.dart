import 'package:flutter/material.dart';
import 'package:micro_yelp/features/profile/presentation/profile_presentation_index.dart';
import '../../../../core/utils/utils_index.dart';
import '../../../authentication/data/repository/shared_preference.dart';
import '../../../authentication/presentation/login.dart';

PreferredSizeWidget? appBar(BuildContext context,
    {required double height, required String title, required double width}) {
  return AppBar(
    elevation: 0,
    backgroundColor: MicroYelpColor.appBarBackgroundColor,
    shadowColor: Colors.transparent,
    centerTitle: true,
    title: Text(title, style: MicroYelpText.internalSubTitle,),
    toolbarHeight: heightCalculator(screenHeight: height, height: 70),
    // actions: [
    //   Transform.scale(
    //     scale: height * 0.0012,
    //     child: Padding(
    //       padding: EdgeInsets.all(width * 0.02),
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //             shape: const CircleBorder(), primary: Colors.orangeAccent),
    //         child: CircleAvatar(
    //           radius: height * 0.03,
    //           backgroundImage: const AssetImage('assets/profile_img.png'),
    //         ),
    //         onPressed: () {
    //           Navigator.pushNamed(context, ReviewerProfilePage.route);
    //         },
    //       ),
    //     ),
    //   )
    // ]
  );
}
