class ReviewerReviewProfile {
  List<String> photos;
  String firstName;
  String lastName;
  String address;
  // String profileId;

  ReviewerReviewProfile(
      {required this.firstName,
      required this.lastName,
      required this.address,
      required this.photos
      // required this.profileId

      });

  factory ReviewerReviewProfile.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return ReviewerReviewProfile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"] ?? "",
        photos: imageList
        // profileId: json["id"],
        );
  }
}
