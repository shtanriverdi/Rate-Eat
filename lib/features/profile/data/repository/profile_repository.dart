import 'dart:io';

import 'package:micro_yelp/features/profile/data/models/reviewer_model_index.dart';
import 'package:micro_yelp/features/profile/data/models/reviewer_profile_model.dart';

import '../datasource/profile_data_layer.dart';

class ReviewerProfileRepository {
  final ReviewerDataProvider reviewerDataProvider;

  ReviewerProfileRepository(this.reviewerDataProvider);

  Future<AppReviewerProfile> getProfileInfo() async {
    return await reviewerDataProvider.getProfileInfo();
  }

  Future<bool> updateProfileInfo(ReviewerProfileInfo profile, List<File> photos) async {
    return await reviewerDataProvider.updateProfileInfo(profile, photos);
  }
}
