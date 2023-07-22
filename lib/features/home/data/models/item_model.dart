class Item {
  String id;
  String name;
  String description;
  String restaurantName;
  List<String> picture;
  int numOfReviews;
  double ratingAverage;
  int price;
  String updatedAt;
  String createdAt;
  List reviews;
  String address;

  Item({
    required this.id,
    required this.name,
    required this.restaurantName,
    required this.description,
    required this.picture,
    required this.numOfReviews,
    required this.ratingAverage,
    required this.price,
    required this.updatedAt,
    required this.createdAt,
    required this.reviews,
    required this.address,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return Item(
        id: json['_id'] ?? "",
        name: json['name'] ?? "Burger",
        restaurantName: (json['ownerId'] == null) ? ("A2SV Restaurant") :
        (json['ownerId']['entityName'] ?? "A2SV Restaurant"),
        address: (json['ownerId'] == null) ? ("Unknown") :
        (json['ownerId']['address'] ?? "Unknown"),
        description: json['description'] ?? "No Description Available",
        picture: imageList.isEmpty ? ['assets/placeholder.png'] : imageList,
        numOfReviews: int.parse((json['numberOfReviews'] ?? 0).toString()),
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
