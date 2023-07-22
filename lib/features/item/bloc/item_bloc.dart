import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/features.dart';
import 'package:micro_yelp/features/item/domain/edit_review.dart';
import 'package:micro_yelp/features/item/domain/vote.dart';
import 'package:micro_yelp/features/item/data/repository/repository.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemsRepo itemsRepo = ItemsRepo();

  ItemBloc() : super(ItemLoading()) {
    on<ItemLoadEvent>((event, emit) async {
      await _onItemLoad(event, emit);
    });

    on<UpVoteEvent>((event, emit) async {
      await _upVoteEvent(event, emit);
    });

    on<SortItemEvent>((event, emit) async{
      await _onSortReviewEvent(event, emit);
    });

    on<DownVoteEvent>((event, emit) async {
      await _downVoteEvent(event, emit);
    });

    on<UpdateReviewEvent>((event, emit) async {
      await _onUpdateReviewEvent(event, emit);
    });
  }

  Future<void> _upVoteEvent(event, emit) async {
    try {
      final review = await itemsRepo.reviewVote(event.vote);
      int len = event.item!.reviews.length;
      final userId = await StorageService.getId();

      int l = 0;
      for (int i = 0; i < len; i += 1) {
        if (event.item!.reviews[i].id == review.id) {
          event.item!.reviews[i] = review;
          l = i;
          break;
        }
      }

      emit(ItemLoadSuccess(event.item, userId));
    } catch (error) {
      emit(ItemLoadFailure(error: "bad request while voting"));
    }
  }

  Future<void> _downVoteEvent(event, emit) async {
    try {
      final review = await itemsRepo.reviewDownVote(event.vote);

      int len = event.item!.reviews.length;
      final userId = await StorageService.getId();

      int l = 0;
      for (int i = 0; i < len; i += 1) {
        if (event.item!.reviews[i].id == review.id) {
          event.item!.reviews[i] = review;
          l = i;
          break;
        }
      }

      emit(ItemLoadSuccess(event.item, userId));
    } catch (error) {
      emit(ItemLoadFailure(error: "bad request while downvoting"));
    }
  }

  Future<void> _onItemLoad(event, emit) async {
    emit(ItemLoading());
    try {
      final items = await itemsRepo.getSingleItem(event.itemId);
      
      String? userId = await StorageService.getId();
      if (userId==null){
        userId = "";
      }
      print(userId);
      emit(ItemLoadSuccess(items, userId));
    } catch (error) {
      emit(ItemLoadFailure(error: "error while loading $error"));
    }
  }

  Future<void> _onUpdateReviewEvent(event, emit) async {
    try {
      final review =
          await itemsRepo.editReview(event.editReview, event.reviewId);

      int len = event.item!.reviews.length;
      final userId = await StorageService.getId();

      int l = 0;
      for (int i = 0; i < len; i += 1) {
        if (event.item!.reviews[i].id == review.id) {
          event.item!.reviews[i] = review;
          l = i;
          break;
        }
      }
      emit(ItemLoadSuccess(event.item, userId));
    } catch (error) {
      emit(ItemLoadFailure(error: "bad request while updating"));
    }
  }

  Future<void> _onSortReviewEvent(event, emit) async{
    try {
        final items = await itemsRepo.getSingleItem(event.itemId);
        String? userId = await StorageService.getId();
        print(userId);
        if (userId==null){
            userId = "";
          }

        event.item!.reviews = items.reviews;
        emit(ItemLoadSuccess(event.item!, userId));
      } catch (error) {
        emit(ItemLoadFailure(error: "bad request while sorting"));
      }
  }

}
