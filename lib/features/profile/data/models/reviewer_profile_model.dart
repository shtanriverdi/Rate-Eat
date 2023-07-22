import 'review_model.dart';
import 'reviewer_info_model.dart';

class AppReviewerProfile {
  ReviewerProfileInfo profile;
  List<ActivityReview> reviews;

  AppReviewerProfile({required this.profile, required this.reviews});

  factory AppReviewerProfile.fromJson(Map<String, dynamic> json) {
    ReviewerProfileInfo newProfile =
        ReviewerProfileInfo.fromJson(json['profile']);
    List<dynamic> newReviews = json['reviews'];
    List<ActivityReview> outPutReviews =
        newReviews.map((review) => ActivityReview.fromJson(review)).toList();

    return AppReviewerProfile(profile: newProfile, reviews: outPutReviews);
  }
}
