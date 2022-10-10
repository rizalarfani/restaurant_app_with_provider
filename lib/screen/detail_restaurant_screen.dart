import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

import '../utils/colors_theme.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final Restaurants? restaurants;
  const DetailRestaurantScreen({Key? key, this.restaurants}) : super(key: key);

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showMore = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        widget.restaurants?.pictureId ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
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
                  widget.restaurants?.name ?? '',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemCount: 5,
                      rating: widget.restaurants?.rating ?? 0,
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
                      widget.restaurants?.rating.toString() ?? '',
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
                          widget.restaurants?.city ?? '',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                showMore == true
                    ? Text(
                        widget.restaurants?.description ?? '',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: Color.fromRGBO(133, 137, 146, 1),
                        ),
                      )
                    : Text(
                        widget.restaurants!.description!.substring(0, 125) +
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
                        setState(() {
                          showMore = !showMore;
                        });
                      },
                      child: Text(
                        showMore ? 'Show Less' : 'Show More',
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                ),
                const SizedBox(height: 22),
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    color: ColorsTheme.primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorsTheme.primaryColor,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Foods',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Drinks',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.restaurants?.menus?.foods?.length ?? 0,
                        itemBuilder: (context, index) {
                          Foods foods =
                              widget.restaurants!.menus!.foods![index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsTheme.primaryColor,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Center(
                              child: Text(
                                foods.name?.toUpperCase() ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.restaurants?.menus?.drinks?.length ?? 0,
                        itemBuilder: (context, index) {
                          Drinks foods =
                              widget.restaurants!.menus!.drinks![index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsTheme.primaryColor,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Center(
                              child: Text(
                                foods.name?.toUpperCase() ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
