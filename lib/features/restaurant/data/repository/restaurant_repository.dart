import '../models/restaurant.dart';
import '../resturant_data_index.dart';

class RestaurantRepository {
  final dataProvider = RestaurantDataProvider();

  Future<RestaurantDetailModel> getRestaurant(String id) async {
    return await dataProvider.getRestaurant(id: id);
  }
}
