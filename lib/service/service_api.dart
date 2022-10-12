import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client, Response;
import 'package:restaurant_app/models/detail_restaurant_model.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import '../utils/constans.dart';

class ServiceApi {
  final String _baseUrl = Constans.baseUrlApi;
  final Client _client = http.Client();

  Future<List<Restaurants>> getListRestaurants() async {
    Uri url = Uri.parse(_baseUrl + 'list');
    Response response = await _client.get(url);
    if (response.statusCode == 200) {
      List? data =
          (jsonDecode(response.body) as Map<String, dynamic>)['restaurants'];
      if (data == null || data.isEmpty) {
        return [];
      } else {
        return data.map((e) => Restaurants.fromJson(e)).toList();
      }
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(response.body);
    }
  }

  // Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
  //   Uri url = Uri.parse(_baseUrl + 'detail/$id');
  //   Response response = await _client.get(url);
  //   if (response.statusCode == 200) {
  //     DetailRestaurantModel restaurant =
  //         (jsonDecode(response.body) as Map<String, dynamic>)['restaurant'];
  //     if (restaurant != null) {
  //       return restaurant;
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
