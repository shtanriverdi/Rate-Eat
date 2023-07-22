import 'package:micro_yelp/features/item/domain/related_items.dart';

class ItemModel {
  String name;
  String description;
  List<String> photos;
  String numberOfReviews;
  Map rating;
  String averageRating;
  String price;
  String id;
  CompanyOwner companyOwner;
  List<Review> reviews;
  List<RelatedItemModel> related_items;
  
  


  ItemModel(
      {required this.name,
      required this.description,
      required this.photos,
      required this.id,
      required this.numberOfReviews,
      required this.rating,
      required this.averageRating,
      required this.price,
      required this.companyOwner,
      required this.reviews,
      required this.related_items
      });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    CompanyOwner companyOwner_ = CompanyOwner.fromJson(json["ownerId"]);
    List<dynamic> list = json["photos"] ?? [];
    List<String> imageList = list.map((im) => im.toString()).toList();


    List<dynamic> related_list = json["relatedItems"] ?? [];
    List<RelatedItemModel> related1 =
        related_list.map((areview) => RelatedItemModel.fromJson(areview)).toList();


    List<dynamic> reviewList = json["reviews"] ?? [];
    List<Review> reviews1 =
        reviewList.map((areview) => Review.fromJson(areview)).toList();

    return ItemModel(
      related_items: related1,
        name: (json["name"] ?? "").toString(),
        description: (json["description"] ?? "No Description").toString(),
        photos: imageList,
        id: (json["_id"] ?? "").toString(),
        numberOfReviews: json["numberOfReviews"].toString(),
        rating: json["rating"] ?? {"1":0, "2":0, "3": 0, "4":0, "5":5},
        price: (json["price"] ?? "0").toString(),
        averageRating: (json["ratingAverage"] ?? "0").toString(),
        companyOwner: companyOwner_,
        reviews: reviews1,
        
        
        );
  }
}

class CompanyOwner {
  String id;
  String entityName;
  String address;

  CompanyOwner(
      {required this.address, required this.entityName, required this.id});

  factory CompanyOwner.fromJson(Map<String, dynamic> json) => CompanyOwner(
      id: (json["_id"] ?? "").toString(),
      entityName: (json["entityName"] ?? "").toString(),
      address: (json["address"] ?? "").toString());
}

class Review {
  String id;
  String rating;
  String textFeedback;
  ReviewerProfile reviewerProfile;
  String itemId;
  List<String> photos;
  String upVotes;
  String downVotes;
  String createdAt;
  // String userId;
  String voted;

  
  

  Review({
    required this.id,
    required this.rating,
    required this.textFeedback,
    required this.reviewerProfile,
    required this.itemId,
    required this.photos,
    required this.upVotes,
    required this.downVotes,
    required this.createdAt,
    // required this.userId,
    required this.voted
  
  
  });
  

  factory Review.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"] ?? [];
    List<String> imageList = list.map((im) => im.toString()).toList();
    ReviewerProfile profile = ReviewerProfile.fromJson(json["reviewerId"]);
    return Review(
      // :(json["rating"] ?? 1).toString(),


      id:(json["_id"] ?? "").toString(),
      rating: (json["rating"] ?? 1).toString(),
      textFeedback: (json["textFeedback"] ?? "").toString(),
      reviewerProfile: profile,
      itemId: (json["itemId"] ?? " ").toString(),
      photos: imageList,
      upVotes: (json["upVotes"] ?? 0).toString(),
      downVotes: (json["downVotes"] ?? 0).toString(),    
      createdAt: (json["created_at"] ?? DateTime.now()).toString(),
      // userId: json["userId"] ?? " ",
      voted: (json["voted"] ?? 0).toString()

    );
  }
}

class ReviewerProfile {
  List<String> photos;
  String firstName;
  String lastName;
  String id;

  ReviewerProfile({
    required this.firstName,
    required this.lastName,
    required this.photos,
    required this.id,
  });

  factory ReviewerProfile.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json["photos"] ?? [];
    List<String> imageList = list.map((im) => im.toString()).toList();

    return ReviewerProfile(
        firstName: (json["firstName"] ?? "").toString(),
        lastName: (json["lastName"] ?? "").toString(),
        photos: imageList,
        id: (json["_id"] ?? "").toString()
      );
    }
}