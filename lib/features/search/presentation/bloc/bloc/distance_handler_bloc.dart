import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'distance_handler_event.dart';
part 'distance_handler_state.dart';

class DistanceHandlerBloc
    extends Bloc<DistanceHandlerEvent, DistanceHandlerState> {
  DistanceHandlerBloc() : super(DistanceHandlerInitial()) {
    on<DistanceHandlerEvent>((event, emit) {
      if (event is LocationEnabledEvent) {
        emit(LocationEnabledState());
      } else if (event is NoLocationEvent) {
        emit(NoLocationState());
      }
    });
  }
}
