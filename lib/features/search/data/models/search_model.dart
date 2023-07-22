class SearchModel {
  String name;
  int paginationPage;
  int paginationLimit;
  double lowerBoundAverageRating;
  double higherBoundAverageRating;
  double lowerBoundPrice;
  double higherBoundPrice;
  String sort;
  List<String> workingHour;
  Set<String> categories;
  Set<String> subCategories;
  String near;
  String longitude;
  String latitude;
  int radius;
  int highLevelIndex;

  SearchModel({
    required this.name,
    required this.categories,
    this.paginationPage = 1,
    this.paginationLimit = 15,
    this.lowerBoundAverageRating = 0,
    this.higherBoundAverageRating = 5,
    this.sort = "price",
    this.workingHour = const ["", ""],
    this.near = "false",
    this.longitude = "",
    this.latitude = "",
    this.radius = 100000,
    this.lowerBoundPrice = 0,
    this.higherBoundPrice = 1000,
    this.highLevelIndex = -1,
    required this.subCategories
  });
}
