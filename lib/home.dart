import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/bottom_navigation_bar_provider.dart';
import 'package:restaurant_app/providers/theme_config_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/screen/location_screen.dart';
import 'package:restaurant_app/screen/notification_screen.dart';
import 'package:restaurant_app/utils/colors_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<BottomNavigationBarProvider>(
          builder: (context, state, _) {
            return IndexedStack(
              index: state.currentIndex,
              children: const [
                HomeScreen(),
                LocationScreen(),
                FavorireScreen(),
                NotificationScreen(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
        builder: (context, state, _) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (value) => state.currentIndex = value,
            selectedItemColor: ColorsTheme.primaryColor,
            unselectedItemColor: ColorsTheme.secundaryTextColor,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: state.currentIndex == 0
                      ? ColorsTheme.primaryColor
                      : ColorsTheme.secundaryTextColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/location.svg',
                  color: state.currentIndex == 1
                      ? ColorsTheme.primaryColor
                      : ColorsTheme.secundaryTextColor,
                ),
                label: 'Locations',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  color: state.currentIndex == 2
                      ? ColorsTheme.primaryColor
                      : ColorsTheme.secundaryTextColor,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  color: state.currentIndex == 3
                      ? ColorsTheme.primaryColor
                      : ColorsTheme.secundaryTextColor,
                ),
                label: 'Notification',
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<ThemeConfigProvider>(
        builder: (context, state, _) {
          return FloatingActionButton(
            backgroundColor:
                state.isDark ? Colors.white : ColorsTheme.primaryColor,
            child: Icon(
              state.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () =>
                state.isDark ? state.isDark = false : state.isDark = true,
          );
        },
      ),
    );
  }
}
