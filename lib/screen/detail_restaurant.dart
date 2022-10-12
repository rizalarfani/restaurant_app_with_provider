import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/colors_theme.dart';

import '../widget/error_text.dart';

class DetailRestaurant extends StatelessWidget {
  const DetailRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hashData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 27,
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: state.restaurant.id ?? '',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/large/${state.restaurant.pictureId}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            width: 38,
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(244, 114, 76, 0.20),
                                  offset: Offset(0, 15),
                                  blurRadius: 23,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.black,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 28,
                              width: 28,
                              margin: const EdgeInsets.only(right: 10, top: 10),
                              decoration: BoxDecoration(
                                color: ColorsTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        state.restaurant.name ?? '',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          RatingBarIndicator(
                            itemCount: 5,
                            rating: state.restaurant.rating ?? 0,
                            itemSize: 20,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                          Text(
                            state.restaurant.rating?.toString() ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/delevery.svg',
                                color: ColorsTheme.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Free delevery',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          const SizedBox(width: 17),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/clock.svg',
                                color: ColorsTheme.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                state.restaurant.city ?? '',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      state.showMore == true
                          ? Text(
                              state.restaurant.description ?? '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Color.fromRGBO(133, 137, 146, 1),
                              ),
                            )
                          : Text(
                              state.restaurant.description!.substring(0, 125) +
                                  ' ...',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Color.fromRGBO(133, 137, 146, 1),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              state.showMore = !state.showMore;
                            },
                            child: Text(
                              state.showMore ? 'Show Less' : 'Show More',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                      ),
                      const SizedBox(height: 22),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
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
    );
  }
}
