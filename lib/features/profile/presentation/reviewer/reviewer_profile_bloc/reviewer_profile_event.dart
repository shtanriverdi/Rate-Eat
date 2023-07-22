part of 'reviewer_profile_bloc.dart';

abstract class ReviewerProfileEvent extends Equatable {
  const ReviewerProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ReviewerProfileEvent {}

class ReviewerProfileEdit extends ReviewerProfileEvent {
  final ReviewerProfileInfo profile;
  final List<File> photos;

  const ReviewerProfileEdit(this.profile, this.photos);

  @override
  List<Object> get props => [profile, photos];
}
