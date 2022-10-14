import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/service/service_api.dart';

import '../models/add_review.dart';

enum ResultState { loading, done, errors }

class ReviewsProvider extends ChangeNotifier {
  final ServiceApi apiServie;
  ReviewsProvider({required this.apiServie});

  List<CustomerReviews>? _customerReviews;
  late ResultState _state;
  String _message = '';

  ResultState get state => _state;
  List<CustomerReviews> get customerReviews => _customerReviews ?? [];
  String get message => _message;

  Future<void> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiServie.addReview(id, name, review);
      if (!result.error!) {
        _state = ResultState.done;
        _customerReviews = result.customerReviews;
        notifyListeners();
        _message = result.message ?? '';
      } else {
        _state = ResultState.errors;
        _message = result.message ?? '';
        notifyListeners();
      }
    } on SocketException catch (_) {
      _state = ResultState.errors;
      notifyListeners();
      _message = 'No Internet Connection, Please check your internet';
    } on Error catch (e) {
      _state = ResultState.errors;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}
