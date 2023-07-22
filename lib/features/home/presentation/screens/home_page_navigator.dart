import 'package:flutter/material.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/home/presentation/constants/static_states.dart';
import 'package:micro_yelp/features/search/presentation/screens/search_page.dart';
import '../../../../core/core.dart';
import '../../../authentication/data/repository/shared_preference.dart';
import '../../../features.dart';
import 'home_page.dart';

class HomePageNavigator extends StatefulWidget {
  const HomePageNavigator({Key? key}) : super(key: key);
  static const String route = "/homePageNavigator";

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  int index = 0;
  bool isLoggedIn = false;

  //TODO: repalce this pages with the real pages of the application
  final screens = [
    const HomePage(),
    const SearchPage(),
    const ReviewerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: HomePageStates.globalKey,
          elevation: 3,
          backgroundColor: MicroYelpColor.appBarBackgroundColor,
          selectedItemColor: MicroYelpColor.primaryColor,
          unselectedLabelStyle: MicroYelpText.bottomNavigationLabel,
          unselectedItemColor: MicroYelpColor.bottomNavigationIconColor,
          selectedFontSize: heightCalculator(screenHeight: height, height: 16),
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (index) async {
            var token = await StorageService.getToken();
            if (index == 2 && token == null) {
              Navigator.pushNamed(context, LoginPage.route);
            } else {
              setState(() => this.index = index);
            }
            // Reset the data on home page
            // HomePageStates.resetHomePageState();
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        body: screens[index],
      ),
    );
  }
}
