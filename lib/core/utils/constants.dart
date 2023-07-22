// This are all the constants required for the app
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_yelp/features/restaurant/data/models/restaurant_model_index.dart';

class MicroYelpText {
  //  the font theme for the main title or the biggest title
  static final mainTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600, fontSize: 34.0, color: Colors.black);
  //  the font theme for the subtitle e.g review, search title ,and others
  static final titleOfPage = GoogleFonts.urbanist(
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
      color: const Color(0xff232323));

  // button name
  static final buttonText = GoogleFonts.urbanist(
      fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.white);
  //  steack salad , sub sub title
  static final internalSubTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
      color: const Color(0XFF3A3A3A));
  static final internalSubTitle1 = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: const Color.fromRGBO(86, 86, 86, 1));
  static final internalSubTitle3 = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: const Color.fromRGBO(86, 86, 86, 1));

  static final phoneNumberStyle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Color.fromRGBO(72, 110, 245, 1));

  static final workinghours = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: const Color.fromRGBO(106, 106, 106, 1));

  static final internalSubTitle2 = GoogleFonts.urbanist(
      fontWeight: FontWeight.w900, fontSize: 13.0, color: Colors.black);

  static final location = GoogleFonts.urbanist(
      fontWeight: FontWeight.w700,
      fontSize: 10.0,
      color: const Color.fromRGBO(77, 139, 184, 1));

  static final restDescription = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500,
      fontSize: 10.0,
      color: const Color.fromRGBO(159, 159, 159, 1));

  static final selected = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: MicroYelpColor.primaryColor);
  static final infoPhoneTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: const Color.fromRGBO(86, 86, 86, 1));

  //  title for categories
  static final categoriesTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.black);

  //  title for all small cards, upload image
  static final smallCardTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black);

  //  title for small review cards, like recent review
  static final smallReviewTitle = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.black);

  //  watermark sth
  static final watermark = GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFA8A8A8));
  // bottom nav bar
  static final bottomApp = GoogleFonts.urbanist(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF787878));

  // price text
  static final price = GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: const Color(0xFFFF7B00));

  //  this is for all profile
  static final profile = GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF5B5B5B));

  // for error messages
  static final error = GoogleFonts.urbanist(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.orange[900]);

  //  for all descrption , review for reviewers
  static final description = GoogleFonts.urbanist(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF7D7D7D));

  // Restaurant Name Style
  static final restaurantName = GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: MicroYelpColor.primaryColor);

  static final description1 = GoogleFonts.urbanist(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF7D7D7D));
  static final sliderLabel = GoogleFonts.urbanist(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 226, 225, 225));

  // for stylish Micro Yelp text
  static final stylishMicroYelp = GoogleFonts.pacifico(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: const Color.fromRGBO(168, 168, 168, 1));

  // for back word on add review screen navbar
  static final back = GoogleFonts.urbanist(
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      color: const Color(0xff232323));
  static final bottomNavigationLabel = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      color: const Color.fromRGBO(120, 120, 120, 1));
  static final reviewDiscription = GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(123, 123, 123, 1));

  static final timeWatermark = GoogleFonts.urbanist(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: const Color.fromRGBO(167, 167, 167, 1));

  static final reviewProfile = GoogleFonts.urbanist(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(95, 95, 95, 1));

  static TextStyle tagStyle(bool isSelected) {
    return GoogleFonts.urbanist(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      letterSpacing: 1.1,
      color: isSelected ? Colors.white : Colors.black,
    );
  }

  static final relatedName = GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(95, 95, 95, 1));

  //new added fonts for the reviewer profile pages
  static final profileText = GoogleFonts.urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: const Color(0xFFFF7B00),
  );

  static final profileName = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: const Color.fromRGBO(68, 68, 68, 1),
  );
  static final profileBio = GoogleFonts.urbanist(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: const Color.fromRGBO(147, 147, 147, 1),
  );
  static final reviewerVote = GoogleFonts.urbanist(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    color: const Color.fromRGBO(26, 26, 26, 1),
  );
  static final reviewerVoteText = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    color: const Color.fromRGBO(141, 141, 141, 1),
  );
  static final activitiesTitle = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: const Color.fromRGBO(86, 86, 86, 1),
  );

  static final selectedDropdown = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: MicroYelpColor.primaryColor,
  );
  static final textFieldText = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: const Color.fromRGBO(45, 45, 45, 1),
  );
  // for back word on add review screen navbar
  static final addReviewMicroYelp = GoogleFonts.urbanist(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: Color(0xFFFF7B00),
  );
  static final detailRestText = GoogleFonts.urbanist(
      fontSize: 19,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF4464B5));
}

class MicroYelpColor {
  // static ThemeData
  static const appBarBackgroundColor = Colors.white;

  static const backgroundForitemdetail = Color.fromRGBO(244, 246, 255, 1);

  // Transparent Color if needed
  static const transparentColor = Colors.transparent;

  // primary color of the app for buttons, icons, selected navigation bar and other
  static const primaryColor = Color(0xFFFF7B00);

  // rgba(255, 136, 0, 1)
  static const starColor = Color.fromRGBO(255, 136, 0, 1);

  // static final secondaryColorIcon = Color(0xFF787878);

  // for normal bottom navbar
  static const secondaryColor = Color(0xFF787878);

  // gradient for splash screen
  static const thirdSplashScreen = [0xFF17A082, 0xFF1FB090, 0xFF1FB090];
  // first splash Screen color
  static const firstSplashScreen = Color(0xFFFFAF4E);

  static const secondSplashScreen = [0xFFF6975E, 0xFFEBA277, 0xFFFAB992];

  // input field color backgound color
  static const inputField = Color(0xFFF1F3FC);

  // Grey Border Color for Cotainer
  static const greyBorder = Color.fromRGBO(217, 217, 217, 1);

  static final internalSubTitle1 = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: const Color.fromRGBO(86, 86, 86, 1));

  // opaque orange color for background
  static const opaqueOrange = Color.fromRGBO(255, 123, 0, 0.08);

  static const blueUploadColor = Color.fromRGBO(94, 94, 255, 1);
  //Icon color
  static const iconColor = Color.fromRGBO(152, 160, 174, 1);
  static const bottomNavigationIconColor = Color.fromRGBO(120, 120, 120, 1);
  static const cardColor = Color(0XFFF1F3FC);
}

class MicroYelpImage {
  static const ampolImage = "assets/images/bulb.png";
  static const bicycleImage = "assets/images/bicycle.png";
  static const finishSignUpImage = "assets/images/finish_sign_up.png";
  static const forgotImage = "assets/images/forgot_password.png";
  static const getStartImage = "assets/images/get_start.png";
  static const loginImage = "assets/images/login.png";
  static const otpImage = "assets/images/otp.png";
  static const signUpImage = "assets/images/sign_up.png";
  static const noResultsImage = "assets/images/no_results.png";
  static const burgerImage = "assets/burger.png";
  static const errorImage = "assets/images/error.png";
  static const landingPageImage = "assets/images/landingPageImage.png";
  static const secondLandingPageImage = "assets/images/half-burguer.png";
  static const userBackupImage = "assets/user_profile_image.png";
}

class MicroYelpUrl {
  static const baseUrl = "https://micro-yelp-eth.herokuapp.com/api/v1";
}
