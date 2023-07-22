import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/features.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MicroYelpImage.secondLandingPageImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(
                  widthCalculator(screenWidth: width, width: 34)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height:
                            heightCalculator(screenHeight: height, height: 8),
                        width: widthCalculator(screenWidth: width, width: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MicroYelpColor.primaryColor,
                        ),
                      ),
                      Container(
                        height:
                            heightCalculator(screenHeight: height, height: 8),
                        width: widthCalculator(screenWidth: width, width: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MicroYelpColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 120),
                  ),
                  Text("Get Started",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 34.0,
                          color: MicroYelpColor.primaryColor)),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 13),
                  ),
                  Text(
                    "Register and start today!",
                    style: MicroYelpText.internalSubTitle.copyWith(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 112, 112, 112)),
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 410),
                  ),
                  // Image.asset(MicroYelpImage.secondLandingPageImage),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 70),
                  ),
                  RoundedButton(
                      buttonText: "Get Started",
                      onClick: () {
                        void fun() async {
                          await StorageService.saveAppState(true);
                        }

                        fun();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            ModalRoute.withName("/signup"));
                      },
                      buttonColor: MicroYelpColor.primaryColor,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 30),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        void fun() async {
                          final prefs = await StorageService.saveAppState(true);
                        }

                        fun();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            ModalRoute.withName("/homepage"));
                      },
                      child: Text(
                        "Continue as guest",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
