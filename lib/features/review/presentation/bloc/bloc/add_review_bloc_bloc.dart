import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/review/data/index.dart';

part 'add_review_bloc_event.dart';
part 'add_review_bloc_state.dart';

class AddReviewBlocBloc extends Bloc<AddReviewBlocEvent, AddReviewBlocState> {
  final AddReviewRepository addReviewRepository;

  AddReviewBlocBloc(this.addReviewRepository) : super(AddReviewBlocInitial()) {
    on<AddReviewEvent>((event, emit) async {
      try {
        emit(const AddReviewupLoading());
        await addReviewRepository.create(event.addReviewModel);
        emit(AddReviewSuccess());
      } catch (error) {
        emit(AddReviewFailure(error: error.toString()));
      }
    });
  }
}
