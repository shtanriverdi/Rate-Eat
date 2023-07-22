import 'dart:convert';
import 'dart:io';
import 'package:micro_yelp/core/utils/constants.dart';
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import 'package:micro_yelp/features/review/review.dart';
import 'package:http/http.dart' as http;

class AddReviewDataProvider {
  Future<AddReviewModel> create(AddReviewModel addReviewModel) async {
    var token = await StorageService.getToken();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    var url = Uri.parse("${MicroYelpUrl.baseUrl}/review");
    var request = http.MultipartRequest('POST', url);
    request.fields["rating"] = addReviewModel.rating.toString();
    request.fields["textFeedback"] = addReviewModel.textfeedback.toString();
    request.fields["itemId"] = addReviewModel.itemID.toString();

    for (int i = 0; i < addReviewModel.imageUrl!.length; i++) {
      request.files.add(http.MultipartFile.fromBytes(
          "photos", File(addReviewModel.imageUrl![i].path).readAsBytesSync(),
          filename: addReviewModel.imageUrl![0].path));
    }
    request.headers.addAll(headers);
    final response = await request.send();
    var respons = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      var s = jsonDecode(respons.body);
      return AddReviewModel.fromJson(s["data"]["review"]);
    }
    {
      throw Exception(respons.body);
    }
  }
}
