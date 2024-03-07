import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/presentation/ui/widgets/categories_card.dart';
import 'package:ecommerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar("Categories", 'https://play.google.com/store/apps/details?id=com.s24ultra.accessoire', context),
        body: gridViewForCategories,
      
    );
  }

  Padding get gridViewForCategories {
    return Padding(
        padding: const EdgeInsets.all(8.0),
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

              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, int index) {
                  return FittedBox(
                    child: CategoriesCard(
                  category: snapshot.data!.docs[index],
                )
                  );
                },
              );
            }

            return const Text("NA");
          },
        ));
  }
}
