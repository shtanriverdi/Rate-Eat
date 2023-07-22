class RestaurantItem {
  String id;
  String name;
  String description;
  List<String> picture;
  int numOfReviews;
  double ratingAverage;
  int price;
  String updatedAt;
  String createdAt;
  List reviews;

  RestaurantItem({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.numOfReviews,
    required this.ratingAverage,
    required this.price,
    required this.updatedAt,
    required this.createdAt,
    required this.reviews,
  });

  factory RestaurantItem.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return RestaurantItem(
        // id: json['_id'] ?? "",
        // name: json['name'] ?? "Burger",
        // description: json['description'] ?? "No Description Available",
        // picture: imageList.isEmpty ? ['assets/burger.png'] : imageList,
        // numOfReviews: json['numOfReviews'] ?? 0,
        // ratingAverage: (json['ratingAverage'] != null)
        //     ? json['ratingAverage'].toDouble()
        //     : 0.0,
        // price: json['price'] ?? 200,
        // updatedAt: json['updatedAt'] ?? "2022-08-24T07:38:46.985Z",
        // createdAt: json['createdAt'] ?? "2022-08-24T07:38:46.985Z",
        // reviews: json['reviews'] ?? []);
        id: json['_id'] ?? "",
        name: json['name'] ?? "Burger",
        description: json['description'] ?? "No Description Available",
        picture: imageList.isEmpty ? ['assets/burger.png'] : imageList,
        numOfReviews: int.parse((json['numOfReviews'] ?? 0).toString()),
        ratingAverage: (json['ratingAverage'] != null)
            ? double.parse((json['ratingAverage']).toString())
            : 0.0,
        price: json['price'] == null
            ? 200
            : int.parse(json['price'].round().toString()),
        updatedAt: json['updatedAt'] ?? "2022-08-24T07:38:46.985Z",
        createdAt: json['createdAt'] ?? "2022-08-24T07:38:46.985Z",
        reviews: json['reviews'] ?? []);
  }
}
