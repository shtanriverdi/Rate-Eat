
import 'package:micro_yelp/features/features.dart';
import 'package:micro_yelp/features/item/data/data_provider.dart/data_provider.dart';
import 'package:micro_yelp/features/item/domain/edit_review.dart';
import 'package:micro_yelp/features/item/domain/vote.dart';
import '../../domain/item_domain_index.dart';


class ItemsRepo{
  ItemProvider itemProvider = ItemProvider();
  ItemsRepo();

  Future<ItemModel> getSingleItem(String id) async{
    final response  = await itemProvider.getSingleItem(id);
    return response;
  }
  
 Future<Review> reviewVote(Vote vote) async {
    return  await itemProvider.reviewVote(vote);
  }

  Future<Review> reviewDownVote(Vote vote) async {
    return await itemProvider.reviewDownVote(vote);
  }

  Future<Review> editReview(EditReview editReview, String revId) async {
    return await itemProvider.editReview(editReview, revId);
  }
}