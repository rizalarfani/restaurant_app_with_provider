import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/service/service_api.dart';

enum ResultState { loading, noData, hashData, errors }

class RestaurantProvider extends ChangeNotifier {
  final ServiceApi apiService;

  RestaurantProvider({required this.apiService}) {
    _getAllRestaurant();
  }

  late List<Restaurants> _restaurants;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<Restaurants> get result => _restaurants;
  ResultState get state => _state;

  Future<dynamic> _getAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getListRestaurants();
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hashData;
        notifyListeners();
        return _restaurants = restaurants;
      }
    } on SocketException catch (_) {
      _state = ResultState.errors;
      notifyListeners();
      return _message = 'No Internet Connection, Please check your internet';
    } on Error catch (e) {
      _state = ResultState.errors;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
