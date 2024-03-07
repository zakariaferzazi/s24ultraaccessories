import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/presentation/ui/screen/categories_screen.dart';

import 'package:ecommerce/presentation/ui/screen/item_screen.dart';
import 'package:ecommerce/presentation/ui/utils/app_color.dart';
import 'package:ecommerce/presentation/ui/widgets/app_bar_icons.dart';
import 'package:ecommerce/presentation/ui/widgets/categories_card.dart';
import 'package:ecommerce/presentation/ui/widgets/home_screen_widgets/home_screen_search_bar.dart';
import 'package:ecommerce/presentation/ui/widgets/home_screen_widgets/home_slider.dart';
import 'package:ecommerce/presentation/ui/widgets/products_card.dart';
import 'package:ecommerce/presentation/ui/widgets/title_header_and_see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeScreenAppBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const HomeScreenSearchBar(),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 182,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('allProducts')
                        .doc("all")
                        .collection('phones')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return HomeSlider(
                          sliders: snapshot.data!.docs,
                        );
                      }

                      return const Text("NA");
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              TitleHeaderAndSeeAllButton(
                title: 'All Categories',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoriesScreen()));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              allCategoriesCardListView,
              popularItemsListView,
              specialItemListView,
              newItemListView,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get newItemListView {
    return SizedBox(
      height: 230,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc("all")
            .collection('cases')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                TitleHeaderAndSeeAllButton(
                  title: "Cases",
                  onTap: () {
                    Get.to(
                      ItemsScreen(
                        title: 'Cases',
                        products: snapshot.data!.docs,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductsCard(
                        product: snapshot.data!.docs[index],
                        isShowDeleteButton: false,
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Text("NA");
        },
      ),
    );
  }

  SizedBox get specialItemListView {
    return SizedBox(
      height: 230,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc("all")
            .collection('screenprotectors')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                TitleHeaderAndSeeAllButton(
                  title: "Screen Protectors",
                  onTap: () {
                    Get.to(
                      ItemsScreen(
                        title: 'Screen Protectors',
                        products: snapshot.data!.docs,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductsCard(
                        product: snapshot.data!.docs[index],
                        isShowDeleteButton: false,
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Text("NA");
        },
      ),
    );
  }

  SizedBox get popularItemsListView {
    return SizedBox(
      height: 230,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc("all")
            .collection('fastcharger')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                TitleHeaderAndSeeAllButton(
                  title: "Fast Chargers",
                  onTap: () {
                    Get.to(
                      ItemsScreen(
                        title: 'Fast Chargers',
                        products: snapshot.data!.docs,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductsCard(
                        product: snapshot.data!.docs[index],
                        isShowDeleteButton: false,
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Text("NA");
        },
      ),
    );
  }

  SizedBox get allCategoriesCardListView {
    return SizedBox(
      height: 90,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allProducts')
            .doc("all").collection('categories')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) {
                return CategoriesCard(
                  category: snapshot.data!.docs[index],
                );
              },
            );
          }

          return const Text("NA");
        },
      ),
    );
  }

  AppBar get homeScreenAppBar {
    return AppBar(
      backgroundColor: AppColor.primaryColor.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset('assets/images/logo.png'),
          )),
          const Spacer(),
          AppBarIcons(
            icon: Icons.share,
            onTap: () {
              Share.share(
                  'https://play.google.com/store/apps/details?id=com.s24ultra.accessoire');
            },
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
