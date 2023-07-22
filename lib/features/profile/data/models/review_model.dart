import 'dart:convert';

import 'reviewer_review_profile.dart';

class ActivityReview {
  String id;
  int rating;
  String textFeedback;
  ReviewerReviewProfile reviewerProfile;
  List<String> itemPhotos;
  int upVotes;
  int downVotes;
  String voted;
  String createdAt;

  ActivityReview(
      {required this.id,
      required this.rating,
      required this.voted,
      required this.textFeedback,
      required this.reviewerProfile,
      required this.itemPhotos,
      required this.upVotes,
      required this.downVotes,
      required this.createdAt});

  factory ActivityReview.fromJson(Map<String?, dynamic> json) {
    List<dynamic> list = json["photos"];
    List<String> imageList = list.map((im) => im.toString()).toList();
    ReviewerReviewProfile profile =
        ReviewerReviewProfile.fromJson(json["reviewerId"]);
    return ActivityReview(
        id: json["_id"],
        voted: (json["voted"] ?? 1).toString(),
        rating: json["rating"],
        textFeedback: json["textFeedback"] ?? "",
        reviewerProfile: profile,
        itemPhotos: imageList,
        upVotes: json["upVotes"],
        downVotes: json["downVotes"],
        createdAt: json["joinedDate"] ?? "");
  }
}
