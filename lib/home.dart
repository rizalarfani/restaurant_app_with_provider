import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/screen/location_screen.dart';
import 'package:restaurant_app/screen/notification_screen.dart';
import 'package:restaurant_app/utils/colors_theme.dart';
import 'package:restaurant_app/utils/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  bool _changeTheme = false;

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex,
          children: const [
            HomeScreen(),
            LocationScrenn(),
            FavoriteScreen(),
            NotificationScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (value) {
          changeTabIndex(value);
        },
        selectedItemColor: ColorsTheme.primaryColor,
        unselectedItemColor: ColorsTheme.secundaryTextColor,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: tabIndex == 0
                  ? ColorsTheme.primaryColor
                  : ColorsTheme.secundaryTextColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/location.svg',
              color: tabIndex == 1
                  ? ColorsTheme.primaryColor
                  : ColorsTheme.secundaryTextColor,
            ),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favorite.svg',
              color: tabIndex == 2
                  ? ColorsTheme.primaryColor
                  : ColorsTheme.secundaryTextColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: tabIndex == 3
                  ? ColorsTheme.primaryColor
                  : ColorsTheme.secundaryTextColor,
            ),
            label: 'Notification',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _changeTheme ? Colors.white : ColorsTheme.primaryColor,
        child: Icon(
          _changeTheme ? Icons.light_mode : Icons.dark_mode,
        ),
        onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('theme', !_changeTheme);
        setState(() {
          _changeTheme = !_changeTheme;
          if (_changeTheme) {
            MyApp.of(context)!.changeTheme(ThemeConfig.darkTheme);
          } else {
            MyApp.of(context)!.changeTheme(ThemeConfig.lightTheme);
          }
        });
      }),
    );
  }
}
