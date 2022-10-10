import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/list_all_restaurants.dart';

import '../models/restaurant_model.dart';
import '../utils/colors_theme.dart';

class RestaurantsAll extends StatefulWidget {
  const RestaurantsAll({Key? key}) : super(key: key);

  @override
  State<RestaurantsAll> createState() => _RestaurantsAllState();
}

class _RestaurantsAllState extends State<RestaurantsAll> {
  List<Restaurants>? allRestaurants;
  bool _isLoading = false;
  late TextEditingController searchControler;
  Future<void> getAllRestaurants() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final json =
        await assetBundle.loadString('assets/json/local_restaurant.json');
    final body = jsonDecode(json);
    final List parsed = body['restaurants'];
    setState(() {
      _isLoading = !_isLoading;
      allRestaurants =
          parsed.map((json) => Restaurants.fromJson(json)).toList();
    });
  }

  void searchRestaurants(String value) async {
    List<Restaurants> results;
    if (value.isEmpty) {
      final assetBundle = DefaultAssetBundle.of(context);
      final json =
          await assetBundle.loadString('assets/json/local_restaurant.json');
      final body = jsonDecode(json);
      final List parsed = body['restaurants'];
      results = parsed.map((json) => Restaurants.fromJson(json)).toList();
    } else {
      results = allRestaurants!
          .where((restaurant) =>
              restaurant.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      allRestaurants = results;
    });
  }

  @override
  void initState() {
    getAllRestaurants();
    searchControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchControler.dispose();
    super.dispose();
  }

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
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.focusedChild?.unfocus();
                        }
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    'All Restaurants',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    height: 51,
                    child: TextField(
                      controller: searchControler,
                      onChanged: (value) => searchRestaurants(value),
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: ColorsTheme.secundaryTextColor,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Find for restaurant...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: ColorsTheme.secundaryTextColor,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color.fromRGBO(118, 127, 157, 1),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(241, 240, 240, 1),
                              width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(241, 240, 240, 1),
                              width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? allRestaurants!.isNotEmpty
                      ? ListView.builder(
                          itemCount: allRestaurants == null
                              ? 0
                              : allRestaurants!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ListAllRestaurants(
                            restaurant: allRestaurants![index],
                          ),
                        )
                      : Center(
                          child: Text(
                            'Restaurant not found',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
