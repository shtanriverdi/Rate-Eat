part of 'item_bloc.dart';

class ItemState {}
                                     
class ItemLoading extends ItemState {}

class ItemLoadSuccess extends ItemState{
  ItemModel? item;
  String? userId;
  ItemLoadSuccess([ this.item , this.userId]);  
}
class ItemReloadSuccess extends ItemState {

}

class ItemLoadFailure extends ItemState {
  final String error;
  ItemLoadFailure({required this.error});
}

