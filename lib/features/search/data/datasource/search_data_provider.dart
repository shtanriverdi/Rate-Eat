import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:micro_yelp/features/search/data/models/search_model.dart';
import 'package:micro_yelp/features/search/utils/helper.dart';

import '../../../home/data/models/item_model.dart';

class SearchDataProvider {
  Future<List<Item>> search(SearchModel req) async {
    try {
      const endPointUrl = "micro-yelp-eth.herokuapp.com";
      const unencodedPath = "api/v1/items";
      final client = http.Client();

      Map<String, String> queryParameters = {
        'page': req.paginationPage.toString(),
        'limit': req.paginationLimit.toString(),
        'near': req.near,
        // 'workingHour': req.workingHour,
        'ratingAverage[gte]': req.lowerBoundAverageRating.toString(),
        'ratingAverage[lte]': req.higherBoundAverageRating.toString(),
        // 'longitude': req.longitude.toString(),
        // 'latitude': req.latitude.toString(),
        'radi': req.radius.toString(),
        'sort': req.sort,
        'price[gte]': req.lowerBoundPrice.toString(),
        'price[lte]': req.higherBoundPrice.toString(),
      };

      if (req.near == "true") {
        queryParameters['longitude'] = req.longitude;
        queryParameters['latitude'] = req.latitude;
      }

      if (req.categories.isNotEmpty) {
        queryParameters['categories'] = req.categories.join(",");
      }

      if (req.name.isNotEmpty) {
        queryParameters['name'] = req.name;
      }

      if (req.workingHour[0].isEmpty) {
        String time = Helper.getGlobalTime();
        var now = Helper.getTimeFromTimeZone(time.trim(), 0);
        var nowPlus1 = Helper.getTimeFromTimeZone(time.trim(), 1);
        req.workingHour = [now, nowPlus1];
      }
      queryParameters['timeRange'] =
          '${req.workingHour[0]},${req.workingHour[1]}';

      final uri = Uri.https(endPointUrl, unencodedPath, queryParameters);
      print(uri);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        List<dynamic> body = json['data'];

        List<Item> items = [];

        items = body.map((dynamic item) => Item.fromJson(item)).toList();
        print("passed");

        return items;
      } else {
        return [];
      }
    } on SocketException catch (_) {
      throw Exception("Connection Problem!");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
