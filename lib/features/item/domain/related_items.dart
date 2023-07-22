class RelatedItemModel{
  String name;
  List<String> photos;
  String averageRating;
  String price;
  String id;


  RelatedItemModel(
      {
      required this.name,
      required this.photos,
      required this.id,
      required this.averageRating,
      required this.price,
      });
  factory RelatedItemModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return RelatedItemModel(

      id:json["_id"].toString(),
      photos: imageList,
      name: json["name"].toString(),
      averageRating: json["ratingAverage"].toString(),
      price: json["price"].toString()
  
    );
  }
}