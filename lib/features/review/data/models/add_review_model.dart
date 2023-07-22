class AddReviewModel {
  double rating;
  String textfeedback;
  List? imageUrl;
  String itemID;

  AddReviewModel({
    required this.rating,
    required this.textfeedback,
    required this.imageUrl,
    required this.itemID,
  });

  factory AddReviewModel.fromJson(Map<String, dynamic> json) {
    return AddReviewModel(
        rating: json['rating'].toDouble(),
        textfeedback: json['textfeedback'].toString(),
        itemID: json['itemID'].toString(),
        imageUrl: json['imageUrl']);
  }
}
