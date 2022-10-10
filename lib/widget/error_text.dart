import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String textError;
  const ErrorText({Key? key, required this.textError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          textError,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
