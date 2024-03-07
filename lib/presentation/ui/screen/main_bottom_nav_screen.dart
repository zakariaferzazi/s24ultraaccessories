import 'package:ecommerce/presentation/ui/screen/categories_screen.dart';
import 'package:ecommerce/presentation/ui/screen/home_screen.dart';
import 'package:ecommerce/presentation/ui/screen/trend_screen.dart';
import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    TrendScreen(),
  ];
  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (controller) {
      return Scaffold(
        body: screens[currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentSelectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColor.primaryColor,
          showSelectedLabels: true,
          type: BottomNavigationBarType.shifting,
          elevation: 4,
          onTap: ((index) {
            setState(() {
              currentSelectedIndex = index;
            });
            
          }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "Home",
                tooltip: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gift), label: "Trend"),
          ],
        ),
      );
    });
  }
}
