
import 'package:micro_yelp/features/restaurant/data/models/restaurant_item_model.dart';

import '../../../home/data/models/item_model.dart';
import '../resturant_data_index.dart';

class RestaurantDetailModel {
  String id;
  String restaurantName;
  String address;
  String description;
String phoneNumber;
  List<String> imagesurl;
  WorkingHours workinghours;
  String weekdays;
  String saturday;
  String sunday;
  List<RestaurantItem> items;
  List<double> coordinates;
  RestaurantDetailModel(
      {required this.id,
      required this.restaurantName,
      required this.address,
      required this.weekdays,
      required this.saturday,
      required this.sunday,
      required this.description,
      required this.phoneNumber,
      required this.imagesurl,
      required this.workinghours,
      required this.items,
      required this.coordinates});
}
