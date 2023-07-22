import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant_item_model.dart';
import '../resturant_data_index.dart';

class RestaurantDataProvider {
  final endPointUrl = "micro-yelp-eth.herokuapp.com";
  final client = http.Client();

  RestaurantDataProvider();

  Future<RestaurantDetailModel> getRestaurant({required String id}) async {
    final unencodedPath = "api/v1/businesses/$id";
    Map<String, String> queryParameters = {'limit': '10'};
    // queryParameters['apiKey'] = ApiConstants.apiKey;

    try {
      final uri = Uri.https(endPointUrl, unencodedPath, queryParameters);
      final response = await client.get(uri);
      List<String> weekday = ['0', '1', '2', '3', '4', '5', '6'];
      Map<String, dynamic> json = jsonDecode(response.body);

      List<RestaurantItem> items = [];
      String restaurantName =
          jsonDecode(response.body)['data']['business']['entityName'];
      String address = jsonDecode(response.body)['data']['business']['address'];
      String description = "One of the best restaurants in town!";
      String phoneNumber =
          jsonDecode(response.body)['data']['business']['phone'];

      String id = jsonDecode(response.body)['data']['business']['_id'];

      List<dynamic> imagesurl =
          jsonDecode(response.body)['data']['business']['photos'];

      String weekdaysWork = jsonDecode(response.body)['data']['business']
          ['newWorkingHours']["weekdays"];
      String saturday = jsonDecode(response.body)['data']['business']
          ['newWorkingHours']["saturday"];
      String sunday = jsonDecode(response.body)['data']['business']
          ['newWorkingHours']["sunday"];
      print(weekdaysWork);
      print(saturday);
      print(sunday);

      List<String> imageList = imagesurl.map((im) => im.toString()).toList();

      List<WeekDay> weekdays = [];

      List<dynamic> locationfromjson = jsonDecode(response.body)['data']
          ['business']['location']['coordinates'];
      List<double> location = [locationfromjson[1], locationfromjson[0]];
      print(location);

      Map<String, dynamic> workinghours =
          jsonDecode(response.body)['data']['business']['workingHours'];
      List<dynamic> jsonitems = jsonDecode(response.body)['data']['items'];

      for (var idx in weekday) {
        Daytime morning = Daytime([
          workinghours[idx]['morning']['openning'],
          workinghours[idx]['morning']['closing']
        ]);
        Daytime afternoon = Daytime([
          workinghours[idx]['afternoon']['openning'],
          workinghours[idx]['afternoon']['closing']
        ]);
        weekdays.add(WeekDay([morning, afternoon]));
      }
      WorkingHours workingHours = WorkingHours(weekdays);

      items = jsonitems
          .map((dynamic item) => RestaurantItem.fromJson(item))
          .toList();

      RestaurantDetailModel restaurant = RestaurantDetailModel(
          restaurantName: restaurantName,
          address: address,
          description: description,
          phoneNumber: phoneNumber,
          weekdays: weekdaysWork,
          saturday: saturday,
          sunday: sunday,
          imagesurl: imageList,
          workinghours: workingHours,
          items: items,
          coordinates: location,
          id: id);

      return restaurant;
    } catch (e) {
      throw ("Can't fetch! $e");
    }
  }
}
