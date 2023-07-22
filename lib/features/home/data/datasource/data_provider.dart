import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/item_model.dart';

class ItemDataProvider {
  // Sample URL
  // https://micro-yelp-eth.herokuapp.com/api/v1/items?&limit=3
  // https://micro-yelp-eth.herokuapp.com/api/v1/items?categories=Burger,Fasting&sort=price
  // Sample URL for nearby
  // {{baseUrl}}/?latitude=56.3214&longitude=70.2315&radi=10000&near=true
  final endPointUrl = "micro-yelp-eth.herokuapp.com";
  final unencodedPath = "api/v1/items";
  final client = http.Client();

  Future<List<Item>> getAllItems(
      {required String categoryParameters,
      required String sortBy,
      required String isFasting,
      required String latitude,
      required String longitude}) async {
    // Sorting Queries
    // To Get Affordable(By price in ascending order):
    // "sort=price"

    // To Get Top Rated(By averageRating in descending order):
    // "sort=-avgRating"

    // To Get Nearby(By price in ascending order):
    // sort= (Backend is working on it)

    // Map<String, String> queryParameters = {'limit': '10'};
    Map<String, String> queryParameters = {
      'limit': '100',
    };

    // Check if parameters are not empty
    if (categoryParameters.isNotEmpty) {
      queryParameters['categories'] = categoryParameters;
    }
    if (sortBy.isNotEmpty) {
      queryParameters['sort'] = sortBy;
    }
    // Parameters for nearby feature
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      queryParameters['latitude'] = latitude;
      queryParameters['longitude'] = longitude;
      // Set the radius and nearby option true
      queryParameters['radi'] = '10000000';
      queryParameters['near'] = 'true';
    }
    // Update fasting parameter
    queryParameters['fasting'] = isFasting;


    try {
      final uri = Uri.https(endPointUrl, unencodedPath, queryParameters);

      // CHECK URI
      // debugPrint("URI: $uri");

      final response = await client.get(uri);

      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['data'];

      List<Item> items = [];

      items = body.map((dynamic item) => Item.fromJson(item)).toList();

      return items;
    } catch (e) {
      throw ("Can't get the Articles! $e");
    }
  }
}
