import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/restaurant.dart';
import '../../data/resturant_data_index.dart';
import '../bloc/restaurant_state.dart';
import 'restaurant_events.dart';




class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {

  final restaurantrepo = RestaurantRepository();
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantEvent>((event, emit) async {
      if (event is LoadRestaurantInfo){
        emit(LoadingRestaurant());
        try{
          final RestaurantDetailModel restaurant = await restaurantrepo.getRestaurant(event.id);
          
          // await Future.delayed(Duration(seconds: 3));
          emit(LoadingSuccessful(restaurant));
        }
        catch(error){
          print("*******************" + error.toString());
          emit(LoadingFailed());
        }
      

      }
    });
  }
  
}