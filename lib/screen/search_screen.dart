import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/error_text.dart';
import 'package:restaurant_app/widget/list_all_restaurants.dart';
import '../models/search_model.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  final List<Restaurants> restaurants;
  const SearchScreen({Key? key, required this.query, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 32,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: 38,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    query + ' (${restaurants.length.toString()})',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/img/profile.png',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            restaurants.isEmpty
                ? const ErrorText(textError: 'Data tidak ditemukan!!')
                : Expanded(
                    child: ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        Restaurants restaurant = restaurants[index];
                        return ListAllRestaurants(
                          restaurant: restaurant,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
