import 'package:flutter/material.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/utils/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    themeState: prefs.getBool('theme'),
  ));
}

class MyApp extends StatefulWidget {
  final bool? themeState;
  const MyApp({Key? key, this.themeState}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late ThemeData _themeData;

  @override
  void initState() {
    _themeData = widget.themeState == null
        ? ThemeConfig.lightTheme
        : ThemeConfig.darkTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Hub',
      theme: _themeData,
      darkTheme: ThemeConfig.darkTheme,
      home: const HomePage(),
    );
  }

  void changeTheme(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }
}
