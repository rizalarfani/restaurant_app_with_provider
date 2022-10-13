import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/service/service_api.dart';

enum ResultState { loading, done, errors }

class ReviewsProvider extends ChangeNotifier {
  final ServiceApi apiServie;
  ReviewsProvider({required this.apiServie});

  late ResultState _state;
  String _message = '';

  ResultState get state => _state;
  String get message => _message;

  Future<void> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiServie.addReview(id, name, review);
      if (!result.error!) {
      } else {
        _message = result.message ?? '';
        notifyListeners();
      }
    } catch (e) {}
  }
}
