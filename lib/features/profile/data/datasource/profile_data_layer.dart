import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:micro_yelp/core/core.dart';
import '../../../authentication/data/repository/shared_preference.dart';
import '../models/reviewer_model_index.dart';

class ReviewerDataProvider {
  Future<AppReviewerProfile> getProfileInfo() async {
    try {
      var token = await StorageService.getToken();
      final response = await http.get(
        Uri.parse("${MicroYelpUrl.baseUrl}/reviewer"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return AppReviewerProfile.fromJson(jsonDecode(response.body)["data"]);
      } else if (response.statusCode == 400) {
        throw Exception("400 status code is sent");
      } else {
        throw Exception("Couldn't find a reviewer information");
      }
    } catch (e) {
      throw Exception("Can't get the profile information!");
    }
  }

  Future<bool> updateProfileInfo(
      ReviewerProfileInfo profile, List<File> photos) async {
    try {
      var token = await StorageService.getToken();
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      var url = Uri.parse("${MicroYelpUrl.baseUrl}/updateUser");
      var request = http.MultipartRequest('PUT', url);
      request.fields["firstName"] = profile.firstName;
      request.fields["lastName"] = profile.lastName;
      request.fields["address"] = profile.address;
      request.fields["bio"] = profile.bio;

      if (photos.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
            "photos", File(photos[photos.length - 1].path).readAsBytesSync(),
            filename: photos[photos.length - 1].path));
      }

      request.headers.addAll(headers);
      final response = await request.send();
      var res = await http.Response.fromStream(response);
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception("Couldn't update user information");
      }
    } catch (e) {
      throw Exception("Server error! ${e.toString()}");
    }
  }
}
