import 'package:flutter/material.dart';
import 'second_page.dart';

import 'first_page.dart';

class OnboardingPages extends StatefulWidget {
  static const String route = "/onboarding";
  const OnboardingPages({Key? key}) : super(key: key);

  @override
  State<OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: const [
        FirstScreen(),
        SecondPage(),
      ],
    );
  }
}
