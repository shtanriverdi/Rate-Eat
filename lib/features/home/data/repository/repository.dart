import 'package:micro_yelp/features/home/data/models/item_model.dart';
import '../datasource/data_provider.dart';

class ItemRepository {
  final ItemDataProvider dataProvider = ItemDataProvider();

  Future<List<Item>> getAllItems(
      {required String categoryParameters,
      required String sortBy,
        required String isFasting,
      required String latitude,
      required String longitude}) async {
    return await dataProvider.getAllItems(
        categoryParameters: categoryParameters,
        sortBy: sortBy,
        isFasting: isFasting,
        latitude: latitude,
        longitude: longitude);
  }
}
