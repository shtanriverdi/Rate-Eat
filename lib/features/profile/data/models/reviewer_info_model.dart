class ReviewerProfileInfo {
  List<String> photos;
  String firstName;
  String lastName;
  String email;
  String address;
  String bio;
  int reviews;
  int upVotes;
  int downVotes;

  ReviewerProfileInfo(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.reviews,
      required this.upVotes,
      required this.downVotes,
      required this.photos,
      required this.address,
      required this.bio});

  factory ReviewerProfileInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return ReviewerProfileInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"] ?? "",
        bio: json["bio"] ?? "",
        reviews: json["reviews"],
        upVotes: json["upVotes"],
        downVotes: json["downVotes"],
        photos: imageList);
  }
}
