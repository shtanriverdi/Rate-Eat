part of 'home_bloc.dart';

class ItemEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllItemsEvent extends ItemEvent {
  final String sortBy;
  final String isFasting;
  final String selectedCategoryParameter;
  final String longitude;
  final String latitude;

  GetAllItemsEvent(
      {required this.sortBy,
      required this.isFasting,
      required this.selectedCategoryParameter,
      required this.latitude,
      required this.longitude});
}

class NoLocationEvent extends ItemEvent {}

class LocationEnabledEvent extends ItemEvent {}
