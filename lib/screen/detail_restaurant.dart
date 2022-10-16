import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/detail_restaurant_model.dart';
import 'package:restaurant_app/providers/detail_restaurant_provider.dart';
import 'package:restaurant_app/providers/reviews_provider.dart' as reviews;
import 'package:restaurant_app/service/service_api.dart';
import 'package:restaurant_app/utils/colors_theme.dart';
import 'package:restaurant_app/widget/list_reviews.dart';

import '../widget/error_text.dart';

class DetailRestaurant extends StatelessWidget {
  final String id;
  const DetailRestaurant({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textControllerName = TextEditingController();
    final TextEditingController textControllerReview = TextEditingController();

    final reviews.ReviewsProvider reviewProvider =
        Provider.of<reviews.ReviewsProvider>(context);

    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (context) =>
          DetailRestaurantProvider(apiService: ServiceApi(), id: id),
      child: Scaffold(
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
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: ColorsTheme.primaryColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    state.restaurant.address ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 17),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 18,
                                  color: ColorsTheme.primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  state.restaurant.city ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
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
                                state.restaurant.description!
                                        .substring(0, 125) +
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
                        DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
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
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Drinks',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: double.infinity,
                                height: 35,
                                child: TabBarView(children: [
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.restaurant.menus?.foods?.length ??
                                            0,
                                    itemBuilder: (context, index) {
                                      Foods foods =
                                          state.restaurant.menus!.foods![index];
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsTheme.primaryColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            )),
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
                                    itemCount: state
                                            .restaurant.menus?.drinks?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      Drinks drinks = state
                                          .restaurant.menus!.drinks![index];
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsTheme.primaryColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Center(
                                          child: Text(
                                            drinks.name?.toUpperCase() ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: ColorsTheme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Customer Reviews (${reviewProvider.customerReviews.isEmpty ? state.restaurant.customerReviews?.length ?? 0 : reviewProvider.customerReviews.length})",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (context) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 24, top: 10),
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.grey
                                                        .withOpacity(0.75),
                                                    size: 25,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Add review restaurant',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorsTheme
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    textControllerName.clear();
                                                    textControllerReview
                                                        .clear();
                                                  },
                                                  child: Text(
                                                    'Clear',
                                                    style: TextStyle(
                                                      color: ColorsTheme
                                                          .secundaryTextColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: TextField(
                                                controller: textControllerName,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: 'Name address',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorsTheme
                                                        .secundaryTextColor,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            241, 240, 240, 1),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            241, 240, 240, 1),
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: TextField(
                                                  controller:
                                                      textControllerReview,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  maxLines: 5,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: 'Review',
                                                    hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorsTheme
                                                          .secundaryTextColor,
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              241, 240, 240, 1),
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              241, 240, 240, 1),
                                                          width: 2.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Consumer<reviews.ReviewsProvider>(
                                              builder: (context, value, _) {
                                                return ElevatedButton(
                                                  onPressed: () async {
                                                    await value.addReview(
                                                        id,
                                                        textControllerName.text,
                                                        textControllerReview
                                                            .text);
                                                    if (value.state ==
                                                        reviews.ResultState
                                                            .loading) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Text(
                                                                    'Loading..'),
                                                                SizedBox(
                                                                    width: 5),
                                                                CircularProgressIndicator(),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else if (value.state ==
                                                        reviews
                                                            .ResultState.done) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          content: Text(
                                                            'successfully added review',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    } else if (value.state ==
                                                        reviews.ResultState
                                                            .errors) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          content: Text(
                                                            value.message,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            ColorsTheme
                                                                .primaryColor),
                                                  ),
                                                  child:
                                                      const Text('Add Review'),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Add review',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reviewProvider.customerReviews.isEmpty
                                ? state.restaurant.customerReviews?.length ?? 0
                                : reviewProvider.customerReviews.length,
                            itemBuilder: (context, index) {
                              var customerReviews =
                                  reviewProvider.customerReviews.isEmpty
                                      ? state.restaurant.customerReviews![index]
                                      : reviewProvider.customerReviews[index];
                              return state.restaurant.customerReviews!.isEmpty
                                  ? const ErrorText(
                                      textError:
                                          'Tidak ada review oleh customer')
                                  : ListReviews(
                                      customerReviews: customerReviews);
                            },
                          ),
                        ),
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
      ),
    );
  }
}
