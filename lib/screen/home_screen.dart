import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screen/restaurant_all_screen.dart';
import 'package:restaurant_app/utils/colors_theme.dart';
import 'package:restaurant_app/widget/list_category.dart';
import 'package:restaurant_app/widget/list_restaurant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  final List<Map<String, dynamic>> _listCategorys = [
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

  List<Restaurants> parseRestaurant(String? json) {
    if (json == null) {
      return [];
    }

    final body = jsonDecode(json);
    final List parsed = body['restaurants'];
    return parsed
        .map((json) => Restaurants.fromJson(json))
        .where((element) => element.rating! > 4.0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Icon(
                      Icons.menu_rounded,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Deliver to',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Pretty View Lane',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
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
              child: Text(
                'What would you like \n to order',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    height: 51,
                    child: TextField(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RestaurantsAll(),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
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
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listCategorys.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> category = _listCategorys[index];
                    return ListCategory(
                      index: index,
                      selected: selectedCategory,
                      title: category.values.first.toString(),
                      img: category.values.last.toString(),
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Populer Restautants',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantsAll(),
                          ));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: 'sofiapro',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ColorsTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 229,
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/json/local_restaurant.json'),
                builder: (context, snapshot) {
                  final List<Restaurants> restaurants =
                      parseRestaurant(snapshot.data);
                  return ListView.builder(
                    itemCount: restaurants.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ListRestaurant(
                      restaurant: restaurants[index],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
