import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const AppBarIcons({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColor.primaryColor,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
