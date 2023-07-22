import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/home/data/repository/repository.dart';
import '../../data/models/item_model.dart';

part 'item_event.dart';

part 'item_state.dart';

class HomeBloc extends Bloc<ItemEvent, ItemState> {
  HomeBloc() : super(ItemInitialState()) {
    on<ItemEvent>((event, emit) async {
      if (event is GetAllItemsEvent) {
        emit(ItemLoadingState());

        try {
          String categoryParameters = event.selectedCategoryParameter;
          String sortBy = event.sortBy;
          String isFasting = event.isFasting;
          String longitude = event.longitude;
          String latitude = event.latitude;

          final ItemRepository itemRepository = ItemRepository();

          List<Item> items = await itemRepository.getAllItems(
              categoryParameters: categoryParameters,
              sortBy: sortBy,
              isFasting: isFasting,
              longitude: longitude,
              latitude: latitude);

          emit(ItemSuccessState(items));
        } catch (e) {
          emit(ItemErrorState());
          throw ("Couldn't fetch data! BLoC Error!$e");
        }
      } else if (event is NoLocationEvent) {
        emit(ItemNoLocationState());
      }
    });
  }
}
