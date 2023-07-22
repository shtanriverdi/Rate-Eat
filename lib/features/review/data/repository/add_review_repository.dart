import 'package:micro_yelp/features/review/data/data_provider/add_review_data_provider.dart';
import 'package:micro_yelp/features/review/data/models/add_review_model.dart';

class AddReviewRepository {
  AddReviewDataProvider addReviewDataProvider;
  AddReviewRepository(this.addReviewDataProvider);

  Future<AddReviewModel> create(AddReviewModel addReviewModel) async {
    return await addReviewDataProvider.create(addReviewModel);
  }
}
