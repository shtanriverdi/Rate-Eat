import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:micro_yelp/features/authentication/data/authentication_data.dart';
import '../../../../core/core.dart';

class AuthProvider {
  Future<dynamic> signUp(User user) async {
    try {
      final response = await http.post(
        Uri.parse("${MicroYelpUrl.baseUrl}/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": user.email,
            "password": user.password,
            "firstName": user.firstName,
            "lastName": user.lastName,
            "role": "REVIEWER",
          },
        ),
      );
      if (response.statusCode == 201) {
        var token = response.headers['token'];
        var id = jsonDecode(response.body)['data']['_id'];
        if (token == null) {
          throw Exception("Something went wrong. Try again!");
        }
        await StorageService.saveToken(token);
        await StorageService.saveId(id);
        return;
      } else if (response.statusCode == 400) {
        throw Exception(convert.jsonDecode(response.body)["errors"]);
      } else {
        throw Exception("Something went wrong!!!");
      }
    } on SocketException catch (_) {
      throw Exception("Connection Problem!");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${MicroYelpUrl.baseUrl}/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        var token = response.headers['token'];
        var id = jsonDecode(response.body)['data'][0]['_id'];
        if (token == null) {
          throw Exception("Something went wrong. Try again!");
        }
        await StorageService.saveToken(token);
        await StorageService.saveId(id);
        return "";
      } else if (response.statusCode == 400) {
        throw Exception(convert.jsonDecode(response.body)["error"]);
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException catch (_) {
      throw Exception("Connection Problem!");
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
