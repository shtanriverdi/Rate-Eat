// This model class will be used for profile page review list part
class RecentReview {
  String personName;
  String description;
  late String lastUpdatedDate;
  String imageUrl;
  int itemRating;

  RecentReview(
      {required this.personName,
      required this.description,
      required this.lastUpdatedDate,
      required this.imageUrl,
      required this.itemRating});
}
