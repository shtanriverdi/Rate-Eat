import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// bloc
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<UpdateCategories>((event, emit) async {
      emit(CategoriesUpdated(highLevelIndex: event.highLevelIndex));
    });
  }
}

// event
abstract class CategoriesEvent extends Equatable {}

class UpdateCategories extends CategoriesEvent {
  int highLevelIndex;
  UpdateCategories({required this.highLevelIndex});
  @override
  List<Object?> get props => [highLevelIndex];
}

// state

abstract class CategoriesState extends Equatable {}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class CategoriesUpdated extends CategoriesState {
  int highLevelIndex;
  CategoriesUpdated({required this.highLevelIndex});
  @override
  List<Object?> get props => [highLevelIndex];
}
