part of 'reviewer_profile_bloc.dart';

abstract class ReviewerProfileState extends Equatable {
  const ReviewerProfileState();

  @override
  List<Object> get props => [];
}

class ReviewerProfileInitial extends ReviewerProfileState {}

class ProfileLoading extends ReviewerProfileState {}

class ProfileLoaded extends ReviewerProfileState {
  final AppReviewerProfile profileInfo;

  const ProfileLoaded(this.profileInfo);

  @override
  List<Object> get props => [profileInfo];
}

class ProfileUpdated extends ReviewerProfileState {}

class PhotoInitial extends ReviewerProfileState {
  @override
  List<Object> get props => [];
}

class ProfileFailure extends ReviewerProfileState {
  final Object message;

  const ProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}
