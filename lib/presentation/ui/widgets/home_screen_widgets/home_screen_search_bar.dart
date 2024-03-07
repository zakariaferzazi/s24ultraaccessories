import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../application/Loader.dart';
import '../../utils/app_color.dart';
import '../products_card.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SearchPage1()));
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),),
        prefixIcon: const Icon(Icons.search),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: "Search",
      ),
    );
  }
}


class SearchPage1 extends StatefulWidget {
  var category;

  SearchPage1({this.category});

  @override
  State<SearchPage1> createState() => _SearchPage1State();
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
class _SearchPage1State extends State<SearchPage1> {
  final searchingKey = GlobalKey<FormState>();

  TextEditingController searchReferance = TextEditingController();

  QuerySnapshot? searchResultSnapshot;
  bool haveUserSearched = false;
  
  searchFunction(String searchField) async {
    return FirebaseFirestore.instance
        .collection('allProducts')
                        .doc("all")
                        .collection('allproducts')
        .orderBy("title")
        .startAt([searchField.capitalize()]).endAt(
            [searchField[0].toLowerCase() + '\uf8ff']).get();
  }

  Widget userList() {
    return haveUserSearched
        ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
            itemCount: searchResultSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return FittedBox(
                    child: ProductsCard(
                      product: searchResultSnapshot!.docs[index],
                      isShowDeleteButton: false,
                    ),
                  );
              
            })
        : StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('allProducts')
                        .doc("all")
                        .collection('popular').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return FittedBox(
                    child: ProductsCard(
                      product: snapshot.data!.docs[index],
                      isShowDeleteButton: false,
                    ),
                  );
                    
                  });
            });
  }

  @override
  Widget build(BuildContext context) {
    initiateSearch() async {
      if (searchReferance.text.isNotEmpty) {
        Loader.start();
        await searchFunction(searchReferance.text).then((snapshot) async {
          searchResultSnapshot = snapshot;
          Loader.stop();
          setState(() {
            haveUserSearched = true;
          });
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.primaryColor,
            title: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Form(
                  key: searchingKey,
                  child: TextFormField(
                    controller: searchReferance,
                    validator: (value) {
                      if (value!.isEmpty) {
                        QuickAlert.show(
                            context: context,
                            title: "Sorry",
                            type: QuickAlertType.warning,
                            text:
                                "please write the accessory you looking for...",
                            confirmBtnText: "Okay");
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                            onTap: () {
                              if (searchingKey.currentState!.validate()) {
                                initiateSearch();
                              }
                            },
                            child: const Icon(Icons.search)),
                        hintText: 'Search',
                        border: InputBorder.none),
                  ),
                ),
              ),
            )),
        body: userList(),
      ),
    );
  }
}