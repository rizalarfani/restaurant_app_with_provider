import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/search_model.dart';
import '../service/service_api.dart';

enum ResultState { loading, noData, hashData, errors }

class SearchRestaurantsProvider extends ChangeNotifier {
  final ServiceApi apiService;

  SearchRestaurantsProvider({required this.apiService});

  late List<Restaurants> _restaurants;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<Restaurants> get result => _restaurants;
  ResultState get state => _state;

  Future<void> searchQuery(String query) async {
    if (query.isEmpty) {
      _state = ResultState.errors;
      _message = 'Pencarian tidak boleh kosong!';
      notifyListeners();
    } else {
      try {
        _state = ResultState.loading;
        notifyListeners();
        var result = await apiService.search(query);
        if (!result.error!) {
          _state = ResultState.hashData;
          _restaurants = result.restaurants ?? [];
          notifyListeners();
        } else {
          _state = ResultState.noData;
          _message = 'Percarian tidak ditemukan!';
          notifyListeners();
        }
      } on SocketException catch (_) {
        _state = ResultState.errors;
        _message = 'No Internet Connection, Please check your internet';
        notifyListeners();
      } on Error catch (e) {
        _state = ResultState.errors;
        _message = 'Error --> $e';
        notifyListeners();
      }
    }
  }
}
