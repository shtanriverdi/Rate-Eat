part of 'distance_handler_bloc.dart';

abstract class DistanceHandlerEvent extends Equatable {}

class NoLocationEvent extends DistanceHandlerEvent {
  @override
  List<Object?> get props => [];
}

class LocationEnabledEvent extends DistanceHandlerEvent {
  @override
  List<Object?> get props => [];
}

