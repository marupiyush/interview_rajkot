import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_rajkot/resources/colors.dart';
import 'package:interview_rajkot/screens/home_screen.dart';
import 'package:interview_rajkot/screens/menu_screen.dart';
import 'package:interview_rajkot/screens/profile_screen.dart';
import 'package:interview_rajkot/screens/recipe_list.dart';
import 'package:interview_rajkot/screens/wish_list_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;
  List screens = [const RecipeList(), const MenuScreen(), const HomeScreen(), const WishListScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 32,
        selectedItemColor: AppColor.secondary,
        unselectedItemColor: AppColor.background,
        onTap: (value) {
          currentIndex = value;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage_rounded),
            activeIcon: Icon(
              Icons.emoji_food_beverage_rounded,
              color: AppColor.primary,
            ),
            label: "Recipe",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon: Icon(
              Icons.menu,
              color: AppColor.primary,
            ),
            label: "Menu Item",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: AppColor.primary,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_sharp),
            activeIcon: Icon(
              Icons.widgets,
              color: AppColor.primary,
            ),
            label: "Wish List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              color: AppColor.primary,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
