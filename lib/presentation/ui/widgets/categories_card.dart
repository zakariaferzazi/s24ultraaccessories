import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/item_screen.dart';

class CategoriesCard extends StatelessWidget {
  final category;
  CategoriesCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          ItemsScreenfromcategory(
            title: category['title'],
            doc: category['title'].replaceAll(" ", ""),
            ),
            );
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
                          category["image"] ?? "",
                          height: 50,
                        ),
    ) 
                      
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        category["title"] ?? "",
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: AppColor.primaryColor,
                            letterSpacing: 0.4),
                      ),
                    ),
                  ),
                ],
              )
            
          ),
    );
  }
}
