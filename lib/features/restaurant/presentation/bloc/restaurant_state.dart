import '../../data/models/restaurant.dart';

abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class LoadingRestaurant extends RestaurantState {}

class LoadingSuccessful extends RestaurantState {
  RestaurantDetailModel restaurant;
// Restaurant restaurant;
  LoadingSuccessful(this.restaurant);
}

class LoadingFailed extends RestaurantState {}
