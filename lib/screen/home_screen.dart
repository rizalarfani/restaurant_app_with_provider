import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/categories_provider.dart';
import 'package:restaurant_app/providers/populars_provider.dart';
import 'package:restaurant_app/providers/search_restaurant_provider.dart'
    as search_provider;
import 'package:restaurant_app/screen/restaurant_all_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/utils/colors_theme.dart';
import 'package:restaurant_app/widget/error_text.dart';
import 'package:restaurant_app/widget/list_category.dart';
import 'package:restaurant_app/widget/list_restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

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
                      controller: searchController,
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
                  Consumer<search_provider.SearchRestaurantsProvider>(
                    builder: (context, value, _) {
                      return Expanded(
                        child: IconButton(
                          onPressed: () async {
                            await value.searchQuery(searchController.text);
                            if (value.state ==
                                search_provider.ResultState.loading) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Loading..'),
                                        SizedBox(width: 5),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (value.state ==
                                search_provider.ResultState.hashData) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SearchScreen(
                                      query: searchController.text,
                                      restaurants: value.result);
                                },
                              ));
                            } else if (value.state ==
                                search_provider.ResultState.errors) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.message),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.search_outlined,
                            size: 35,
                            color: ColorsTheme.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                height: 100,
                child: Consumer<CategoriesProvider>(
                  builder: (context, categories, _) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.listCategories.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> category =
                          categories.listCategories[index];
                      return ListCategory(
                        index: index,
                        selected: categories.selectedCategory,
                        title: category.values.first.toString(),
                        img: category.values.last.toString(),
                        onTap: () {
                          Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .changeCategory(index);
                        },
                      );
                    },
                  ),
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
              child: Consumer<PopularsProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.hashData) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ListRestaurant(
                        restaurant: state.result[index],
                      ),
                    );
                  } else if (state.state == ResultState.noData) {
                    return ErrorText(textError: state.message);
                  } else if (state.state == ResultState.errors) {
                    return ErrorText(textError: state.message);
                  } else {
                    return ErrorText(textError: state.message);
                  }
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
