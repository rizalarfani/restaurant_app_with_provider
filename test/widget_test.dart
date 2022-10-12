// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client, Response;

void main() {
  final Client _client = http.Client();
  Future<void> getDetailRestaurant(String id) async {
    Uri url = Uri.parse('https://restaurant-api.dicoding.dev/detail/$id');
    Response response = await _client.get(url);
    print(response);
  }

  getDetailRestaurant('rqdv5juczeskfw1e867');
}
