import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../screen/main_bottom_nav_screen.dart';
import 'app_bar_icons.dart';

AppBar customAppBar(String title,String link, BuildContext context) {
  return AppBar(
    title: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 20),),
          const Spacer(),
          AppBarIcons(
            icon: Icons.share,
            onTap: () {
              Share.share(link);
            },
          ),
          const SizedBox(
            width: 12,
          ),
          
        ],
      ),
    leading: IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNavBarScreen()));
        },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    ),
    
  );
}

