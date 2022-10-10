import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/service/service_api.dart';

enum ResultState { loading, noData, hashData, errors }

class PopularsProvider extends ChangeNotifier {
  final ServiceApi apiService;

  PopularsProvider({required this.apiService}) {
    _getPopularRestaurants();
  }

  late List<Restaurants> _restaurants;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<Restaurants> get result => _restaurants;
  ResultState get state => _state;

  Future<dynamic> _getPopularRestaurants() async {
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
        return _restaurants =
            restaurants.where((element) => element.rating > 4).toList();
      }
    } catch (e) {
      _state = ResultState.errors;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
