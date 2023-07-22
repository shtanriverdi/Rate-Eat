import 'package:micro_yelp/features/search/data/datasource/search_data_provider.dart';
import 'package:micro_yelp/features/search/data/models/search_model.dart';

import '../../../home/data/models/item_model.dart';

class SearchRepository {
  final SearchDataProvider searchDataProvider;

  SearchRepository({required this.searchDataProvider});

  Future<List<Item>> search(SearchModel req) async {
    try {
      return await searchDataProvider.search(req);
    } catch (e) {
      rethrow;
    }
  }
}
