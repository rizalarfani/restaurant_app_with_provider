import 'package:flutter/cupertino.dart';

class CategoriesProvider extends ChangeNotifier {
  int _selectedCatergory = 0;
  final List<Map<String, dynamic>> _listCategories = [
    {
      'title': 'Burger',
      'img': 'assets/img/burger.png',
    },
    {
      'title': 'Donat',
      'img': 'assets/img/donat.png',
    },
    {
      'title': 'Pizza',
      'img': 'assets/img/pizza.png',
    },
    {
      'title': 'Mexican',
      'img': 'assets/img/mexian.png',
    },
    {
      'title': 'Asian',
      'img': 'assets/img/asian.png',
    },
  ];

  int get selectedCategory => _selectedCatergory;
  List<Map<String, dynamic>> get listCategories => _listCategories;

  void changeCategory(int value) {
    _selectedCatergory = value;
    notifyListeners();
  }
}
