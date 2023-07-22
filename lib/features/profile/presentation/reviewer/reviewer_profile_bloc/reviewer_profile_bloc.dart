import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile.dart';
part 'reviewer_profile_event.dart';
part 'reviewer_profile_state.dart';

class ReviewerProfileBloc
    extends Bloc<ReviewerProfileEvent, ReviewerProfileState> {
  final ReviewerProfileRepository reviewerProfileRepository;
  ReviewerProfileBloc(this.reviewerProfileRepository)
      : super(ReviewerProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try {
        final res = await reviewerProfileRepository.getProfileInfo();
        emit(ProfileLoading());
        emit(ProfileLoaded(res));
      } catch (e) {
        emit(ProfileFailure(e));
      }
    });
    on<ReviewerProfileEdit>((event, emit) async {
      try {
        final res =
            await reviewerProfileRepository.updateProfileInfo(event.profile, event.photos);
        if (res == true) {
          emit(ProfileUpdated());
          final response = await reviewerProfileRepository.getProfileInfo();
          emit(ProfileLoading());
          emit(ProfileLoaded(response));
        } else {
          emit(const ProfileFailure("Couldn't update profile info"));
        }
      } catch (e) {
        emit(ProfileFailure(e));
      }
    });
  }
}
