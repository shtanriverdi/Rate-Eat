abstract class RestaurantEvent {}

class LoadRestaurantInfo extends RestaurantEvent {
  String id;
  LoadRestaurantInfo({required this.id});

  @override
  List<Object> get props => [id];
}
