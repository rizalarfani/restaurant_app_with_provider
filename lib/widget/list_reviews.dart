import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/colors_theme.dart';

class ListReviews extends StatelessWidget {
  final dynamic customerReviews;
  const ListReviews({Key? key, required this.customerReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Image.asset(
                'assets/img/profile.png',
              ),
            ),
          ),
          title: Text(
            customerReviews.name ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    size: 15,
                    color: ColorsTheme.primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    customerReviews.date ?? '',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          customerReviews.review ?? '',
          style: Theme.of(context).textTheme.caption,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
          thickness: 1,
        )
      ],
    );
  }
}
