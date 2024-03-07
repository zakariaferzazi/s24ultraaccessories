import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/presentation/ui/widgets/custom_app_bar.dart';
import 'package:ecommerce/presentation/ui/widgets/products_card.dart';
import 'package:flutter/material.dart';

class TrendScreen extends StatefulWidget {




  @override
  State<TrendScreen> createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Trend','https://play.google.com/store/apps/details?id=com.s24ultra.accessoire', context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('allProducts')
              .doc("all")
              .collection('allproducts')
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
                itemCount: snapshot.data!.docs.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, int index) {
                  return FittedBox(
                    child: ProductsCard(
                      product: snapshot.data!.docs[index],
                      isShowDeleteButton: false,
                    ),
                  );
                },
              );
            }

            return const Text("NA");
          },
        ),
      ),
    );
  }
}
