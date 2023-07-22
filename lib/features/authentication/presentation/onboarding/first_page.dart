import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/features.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const TextStyle skipTextStyle = TextStyle(
      color: MicroYelpColor.primaryColor,
      fontSize: 16,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: widthCalculator(screenWidth: width, width: 14),
                horizontal: widthCalculator(screenWidth: width, width: 34)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height:
                              heightCalculator(screenHeight: height, height: 8),
                          width: widthCalculator(screenWidth: width, width: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MicroYelpColor.primaryColor,
                          ),
                        ),
                        Container(
                          height:
                              heightCalculator(screenHeight: height, height: 8),
                          width: widthCalculator(screenWidth: width, width: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MicroYelpColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {
                        void fun() async {
                          final prefs = await StorageService.saveAppState(true);
                        }

                        fun();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            ModalRoute.withName("/signup"));
                      },
                      child: const Text(
                        'skip',
                        style: skipTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightCalculator(screenHeight: height, height: 100),
                ),
                Text(
                  'Find the best',
                  style: MicroYelpText.mainTitle
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    Text(
                      "Items",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 34.0,
                          color: MicroYelpColor.primaryColor),
                    ),
                    Text(
                      " & ",
                      style: MicroYelpText.mainTitle
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Services",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 34.0,
                          color: MicroYelpColor.primaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: heightCalculator(screenHeight: height, height: 11),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 58),
                  child: Text(
                    "Give review to items you like and share with everyone!",
                    style: MicroYelpText.watermark
                        .copyWith(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: heightCalculator(screenHeight: height, height: 30),
                ),
                Stack(
                  children: [
                    Image.asset(MicroYelpImage.landingPageImage),
                    const Positioned(child: OnBoardingCard()),
                    const Positioned(
                        right: 0, bottom: 0, child: OnBoardingCard())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
