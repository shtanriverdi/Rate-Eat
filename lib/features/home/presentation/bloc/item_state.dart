part of 'home_bloc.dart';

class ItemState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemErrorState extends ItemState {}

class ItemNoLocationState extends ItemState {}

class ItemSuccessState extends ItemState {
  final List<Item> items;
  ItemSuccessState(this.items);
}
