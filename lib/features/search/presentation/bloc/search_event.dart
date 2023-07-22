
import 'package:equatable/equatable.dart';
import '../../data/models/search_model.dart';

abstract class SearchEvent extends Equatable {}

class SearchSubmitted extends SearchEvent {
  final SearchModel req;
  SearchSubmitted({required this.req});

  @override
  List<Object?> get props => [req];
}
