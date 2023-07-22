double widthCalculator(
    {double figmaWidth = 428,
    required double screenWidth,
    required double width}) {
  return width / figmaWidth * screenWidth;
}

double heightCalculator(
    {double figmaHeight = 926,
    required double screenHeight,
    required double height}) {
  return height / figmaHeight * screenHeight;
}
