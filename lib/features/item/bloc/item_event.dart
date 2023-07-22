part of 'item_bloc.dart';

class ItemEvent extends Equatable {
  const ItemEvent();
  @override
  List<Object> get props => [];
} 

class ItemLoadEvent extends ItemEvent {
  String itemId;
  ItemLoadEvent({required this.itemId});
  @override
  List<Object> get props => [];
} 

class UpVoteEvent extends ItemEvent {
  final Vote vote;
  final ItemModel item;
  const UpVoteEvent({required this.vote, required this.item});

  @override
    List<Object> get props => [vote]; 


}

class DownVoteEvent extends ItemEvent {

  final Vote vote;
  final ItemModel item;
  const DownVoteEvent({required this.vote, required this.item});

  @override
    List<Object> get props => [vote]; 


} 

class UpdateReviewEvent extends ItemEvent {

  final EditReview editReview;
  final String reviewId;
  final String itemId;
  final ItemModel item;
  const UpdateReviewEvent({required this.editReview, required this.reviewId, required this.itemId, required this.item});
  @override
    List<Object> get props => [editReview,reviewId];


} 

class SortItemEvent extends ItemEvent {
  final String itemId;
  final ItemModel item;
  const SortItemEvent({required this.itemId, required this.item});

  @override
    List<Object> get props => [itemId]; 


}