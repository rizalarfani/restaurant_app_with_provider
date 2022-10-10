import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

import '../screen/detail_restaurant_screen.dart';
import '../utils/colors_theme.dart';

class ListAllRestaurants extends StatelessWidget {
  final Restaurants? restaurant;
  const ListAllRestaurants({Key? key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailRestaurantScreen(
                restaurants: restaurant,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(211, 209, 216, 0.35),
                offset: Offset(15, 15),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      restaurant!.pictureId!,
                      fit: BoxFit.cover,
                      height: 228,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 28,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(244, 114, 76, 0.20),
                          offset: Offset(0, 15),
                          blurRadius: 23,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant?.rating.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.yellow,
                        ),
                      ],
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      restaurant?.name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8),
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
                              restaurant?.city ?? '',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
