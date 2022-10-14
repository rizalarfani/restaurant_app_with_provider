import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/detail_restaurant_model.dart';
import '../service/service_api.dart';

enum ResultState { loading, noData, hashData, errors }

class DetailRestaurantProvider extends ChangeNotifier {
  final ServiceApi apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _getDetailRestaurant();
  }

  late Restaurant _restaurants;
  late List<CustomerReviews> _customerReviews;
  late ResultState _state;
  String _message = '';
  bool _showMore = false;

  Restaurant get restaurant => _restaurants;
  List<CustomerReviews> get customerReviews => _customerReviews;
  ResultState get state => _state;
  String get message => _message;
  bool get showMore => _showMore;

  set showMore(bool value) {
    _showMore = value;
    notifyListeners();
  }

  Future<dynamic> _getDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(id);
      if (restaurant.error == false) {
        _state = ResultState.hashData;
        _customerReviews = restaurant.restaurant!.customerReviews!;
        notifyListeners();
        return _restaurants = restaurant.restaurant!;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = restaurant.message ?? '';
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
