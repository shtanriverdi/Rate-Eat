import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:micro_yelp/features/authentication/data/repository/shared_preference.dart';
import 'package:micro_yelp/features/item/domain/edit_review.dart';
import 'package:micro_yelp/features/item/domain/vote.dart';

import '../../domain/item_domain_index.dart';

class ItemProvider {
  Future<ItemModel> getSingleItem(String id) async {
    final token = await StorageService.getToken();

    final response = await http.get(
      Uri.parse("https://micro-yelp-eth.herokuapp.com/api/v1/items/$id"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    );
    print(jsonDecode(response.body)["item"]);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)["item"]);
      return ItemModel.fromJson(jsonDecode(response.body)["item"]);
    } else {
      throw Exception("error fetching medicine");
    }
  }

  Future<Review> reviewVote(Vote vote) async {
    final token = await StorageService.getToken();
    print("tamiratttttttttttttt");

    final response = await http.post(
        Uri.parse("https://micro-yelp-eth.herokuapp.com/api/v1/votes/upvote"),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          // 'token': token!
        },
        body: jsonEncode({"reviewId": vote.reviewId}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body)['review']);
    } else {
      throw Exception('failed to vote review');
    }
  }

  Future<Review> reviewDownVote(Vote vote) async {
    final token = await StorageService.getToken();

    final response = await http.post(
        Uri.parse("https://micro-yelp-eth.herokuapp.com/api/v1/votes/downVote"),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"reviewId": vote.reviewId}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body)['review']);
    } else {
      throw Exception('failed to vote review');
    }
  }

  Future<Review> editReview(EditReview editReview, String revId) async {
    final token = await StorageService.getToken();
    final response = await http.put(
      Uri.parse("https://micro-yelp-eth.herokuapp.com/api/v1/review/$revId"),
      headers: <String, String>{
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(editReview),
    );
    print(jsonDecode(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // todo backend
      return Review.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('failed to editing review');
    }
  }
}
