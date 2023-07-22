
class Vote {
  String reviewId;
  String itemId;

  Vote({required this.reviewId,  required this.itemId});


  Map<String, dynamic> toJson() =>
      {"reviewId": reviewId};
}