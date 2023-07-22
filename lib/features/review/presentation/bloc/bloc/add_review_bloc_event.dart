part of 'add_review_bloc_bloc.dart';

abstract class AddReviewBlocEvent extends Equatable {}

class AddReviewEvent extends AddReviewBlocEvent {
  final AddReviewModel addReviewModel;
  AddReviewEvent(this.addReviewModel);

  @override
  List<Object> get props => [];
}
