import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:ecommerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:ecommerce/presentation/ui/widgets/love_icon_button.dart';
import 'package:ecommerce/presentation/ui/widgets/products_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final product;

  const ProductsDetailsScreen({super.key, required this.product});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProductsDetailsController>()
    //       .getProductsDetails(widget.productsId);
    //   Get.find<ProductsDetailsController>().availableColor.clear();
    // });
  }

  Future<void> _launchUrl(_url) async {
    final Uri url = Uri.parse(_url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBar("Products Details", widget.product['link'], context),
        body: Column(
          children: [
            ProductsDetailsCarouselSlider(
              imageList: [
                widget.product['images'][0] ?? "",
                widget.product['images'][1] ?? "",
                widget.product['images'][2] ?? "",
                widget.product['images'][3] ?? "",
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: productsDetails(
                    widget.product,
                  ),
                ),
              ),
            ),
            cartBottomContainer(
              widget.product,
            ),
          ],
        ));
  }

  Column productsDetails(
    product,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product['title'] ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (product['review'] == "3")
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                ],
              )
            else if (product['review'] == "4")
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  ),
                  Icon(
                    Icons.star,
                    size: 22,
                    color: Color.fromARGB(255, 255, 166, 0),
                  )
                ],
              )
            else if (product['review'] == "5")
              const Row(children: [
                Icon(
                  Icons.star,
                  size: 22,
                  color: Color.fromARGB(255, 255, 166, 0),
                ),
                Icon(
                  Icons.star,
                  size: 22,
                  color: Color.fromARGB(255, 255, 166, 0),
                ),
                Icon(
                  Icons.star,
                  size: 22,
                  color: Color.fromARGB(255, 255, 166, 0),
                ),
                Icon(
                  Icons.star,
                  size: 22,
                  color: Color.fromARGB(255, 255, 166, 0),
                ),
                Icon(
                  Icons.star,
                  size: 22,
                  color: Color.fromARGB(255, 255, 166, 0),
                )
              ])
            else
              const Icon(
                Icons.star,
                size: 22,
                color: Color.fromARGB(255, 255, 166, 0),
              ),
            Text(
              '${product['review'] ?? ""}',
              style: const TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            TextButton(
              onPressed: () {
                Share.share(widget.product['link']);
              },
              child: const Row(
                children: [
                  Text(
                    "Share",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  FavoriteLoveIconButton(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        Text(
          product['title'] ?? "",
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Container cartBottomContainer(
    final productsDetails,
  ) {
    String price = productsDetails['price'];
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        color: AppColor.primaryColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  price.contains("\n")
                      ? price.substring(0, price.indexOf('\n'))
                      : price,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                _launchUrl(productsDetails['link']);
              },
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColor.primaryColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Go to',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/amazon.jpg",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
