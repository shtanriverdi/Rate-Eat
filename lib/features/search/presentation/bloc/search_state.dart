import 'package:equatable/equatable.dart';

import '../../../home/data/models/item_model.dart';

abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchResultLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchResultError extends SearchState {
  final String error;
  SearchResultError({required this.error});
  @override
  List<Object?> get props => [error];
}

class SearchResultLoaded extends SearchState {
  final List<Item> items;
  SearchResultLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}
