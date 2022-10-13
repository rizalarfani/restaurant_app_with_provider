import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client, Response;
import 'package:restaurant_app/models/customer_review_model.dart';
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

  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    Uri url = Uri.parse(_baseUrl + 'detail/$id');
    var response = await _client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailRestaurantModel restaurants = DetailRestaurantModel.fromJson(data);
      return restaurants;
    } else if (response.statusCode == 404) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw (response.body);
    }
  }

  Future<CustomerReviewModel> addReview(
      String id, String name, String review) async {
    Uri url = Uri.parse(_baseUrl + 'review');
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    Response response = await _client.post(url, headers: headers, body: {
      'id': id,
      'name': name,
      'review': review,
    });
    if (response.statusCode == 200) {
      return CustomerReviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw (response.body);
    }
  }
}
