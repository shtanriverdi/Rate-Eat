import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_event.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_state.dart';
import 'package:micro_yelp/features/search/utils/helper.dart';
import '../../../home/data/models/item_model.dart';
import '../../data/repository/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;
  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchSubmitted>((event, emit) async {
      emit(SearchResultLoading());

      try {
        // String categoryParameters = event.selectedCategoryParameter;
        // String sortBy = event.sortBy;

        // final ItemRepository itemRepository = ItemRepository();

        List<Item> items = await searchRepository.search(event.req);

        emit(SearchResultLoaded(items: items));
      } catch (e) {
        String error = Helper.removeException(e.toString());
        emit(SearchResultError(error: error));
      }
    });
  }
}
