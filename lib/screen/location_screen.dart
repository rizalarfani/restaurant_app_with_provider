import 'package:flutter/material.dart';

class LocationScrenn extends StatefulWidget {
  const LocationScrenn({Key? key}) : super(key: key);

  @override
  State<LocationScrenn> createState() => _LocationScrennState();
}

class _LocationScrennState extends State<LocationScrenn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Location'),
      ),
    );
  }
}
