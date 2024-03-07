import 'package:ecommerce/presentation/ui/screen/products_details_screen.dart';
import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({
    super.key,
    required this.product,
    required this.isShowDeleteButton,
  });

  final product;
  final bool isShowDeleteButton;
  

  @override
  Widget build(BuildContext context) {
    String price = product['price'];

    return InkWell(
      onTap: () {
        Get.to(() => ProductsDetailsScreen(product: product));
      },
      child: Card(
        elevation: 5,
        shadowColor: AppColor.primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: NetworkImage(
                        product['images'][0] ??
                            'https://assets.adidas.com/images/w_600,f_auto,q_auto/f9d52817f7524d3fb442af3b01717dfa_9366/Runfalcon_3.0_Shoes_Black_HQ3790_01_standard.jpg',
                      ),
                      fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'] ?? "New year sell Shoe",
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
                    ),
                    Row(
                      children: [
                        Text(
                              price.contains("\n") ? 
                          price.substring(0, price.indexOf('\n')) : price,
                          style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.amber,
                            ),
                            Text(
                              "${product['review']}",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: AppColor.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                isShowDeleteButton == false
                                    ? Icons.favorite_border
                                    : Icons.delete,
                                size: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          onTap: () {
                  
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
