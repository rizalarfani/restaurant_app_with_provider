import 'package:flutter/material.dart';

class FavorireScreen extends StatelessWidget {
  const FavorireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorite',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
