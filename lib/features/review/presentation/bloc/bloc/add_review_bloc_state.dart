part of 'add_review_bloc_bloc.dart';

abstract class AddReviewBlocState extends Equatable {
  const AddReviewBlocState();

  @override
  List<Object> get props => [];
}

class AddReviewBlocInitial extends AddReviewBlocState {}

class AddReviewupLoading extends AddReviewBlocState {
  const AddReviewupLoading();

  @override
  List<Object> get props => [];
}

class AddReviewSuccess extends AddReviewBlocState {

  @override
  List<Object> get props => [];
}

class AddReviewFailure extends AddReviewBlocState {
  final String error;
  const AddReviewFailure({required this.error});

  @override
  List<Object> get props => [error];
}
