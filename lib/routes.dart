import 'package:flutter/material.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page_navigator.dart';
import 'package:micro_yelp/features/item/presentation/item_detail.dart';
import 'features/home/presentation/screens/home_page.dart';
import 'features/features.dart';
import 'features/restaurant/restaurant.dart';
import 'features/review/review.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
      case OnboardingPages.route:
        return MaterialPageRoute(builder: (context) {
          return const OnboardingPages();
        });
      case HomePageNavigator.route:
        return MaterialPageRoute(builder: (context) {
          return const HomePageNavigator();
        });
      case LoginPage.route:
        return MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });
      case SignUpPage.route:
        return MaterialPageRoute(builder: (context) {
          return const SignUpPage();
        });
      case ReviewerProfilePage.route:
        return MaterialPageRoute(builder: (context) {
          return const ReviewerProfilePage();
        });
      // case EditReviewerProfile.route:
      //   return MaterialPageRoute(builder: (_) {
      //     return EditReviewerProfile(profile: settings.arguments);
      //   });
      // case AddReview.route:
      //   return MaterialPageRoute(builder: (context) {
      //     return AddReview();
      //   });
      case RestaurantDetail.route:
        return MaterialPageRoute(builder: (context) {
          return const RestaurantDetail();
        });

      case ItemDetail.route:
        return MaterialPageRoute(builder: (context) {
          return const ItemDetail();
        });
    }
    return null;
  }
}
