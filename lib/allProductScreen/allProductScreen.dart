import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/models/product.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/widgets/ProductCard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants.dart';
import '../widgets/commonProductCard.dart';
import '../widgets/customAppBar.dart';
import '../widgets/searchProduct.dart';

class AllProductScreen extends StatefulWidget {
  static String routeName = '/profileScreen';

  const AllProductScreen({Key? key}) : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  void initState() {
    // super
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var loadedProducts =
    //     Provider.of<ProductsProvider>(context, listen: false).items;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "ALL PRODUCTS",
                style: kTextAppBarTitle,
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchItem());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.search,
                      size: 18,
                    )),
              ],
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "A Watch for Every Kind of Wrist",
                textAlign: TextAlign.center,
                style: kHeadingTitle,
              ),
              _buildProducts(),
              // StreamBuilder<QuerySnapshot>(
              //     stream: products,
              //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //       if (snapshot.hasError) {
              //         const Text("Something went wrong");
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Text("Data loading");
              //       }
              //       final productData = snapshot.requireData;
              //       return GridView.builder(
              //         // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 40),
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: productData.size,
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           mainAxisSpacing: 10.0,
              //           crossAxisSpacing: 0,
              //           childAspectRatio: 0.7,
              //         ),
              //         itemBuilder: (ctx, i) => InkWell(
              //           onTap: () {
              //             pushNewScreenWithRouteSettings(
              //               context,
              //               screen: ProductDetailScreen(),
              //               withNavBar: false,
              //               settings:
              //                   RouteSettings(arguments: loadedProducts[i].id),
              //             );
              //             print(productData.docs[i].id);
              //
              //             print(productData.docs[i]['uid']);
              //           },
              //           child: CommonProduct(
              //               imageUrl: loadedProducts[i].imageUrl,
              //               title: loadedProducts[i].title,
              //               price: loadedProducts[i].price.toString()),
              //         ),
              //
              //         // child: CommonProduct(
              //         //   title: productData.docs[i]['name'],
              //         //   imageUrl: productData.docs[i]['imagePath'],
              //         //   price: productData.docs[i]['price'].toString(),
              //         // )),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProducts() => Consumer<ProductsProvider>(
        builder: (context, provider, child) {
          if (provider.productsFetching)
            return const Center(child: Text('Loading'));
          return GridView.builder(
            // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 40),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (ctx, i) => InkWell(
              onTap: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: ProductDetailScreen(),
                  withNavBar: false,
                  settings:
                      RouteSettings(arguments: provider.items[i].id.toString()),
                );
                // print(productData.docs[i].id);

                // print(productData.docs[i]['uid']);
              },
              child: CommonProduct(
                imageUrl: provider.items[i].imageUrl,
                title: provider.items[i].title,
                price: provider.items[i].price.toString(),
              ),

              // child: CommonProduct(
              //   title: productData.docs[i]['name'],
              //   imageUrl: productData.docs[i]['imagePath'],
              //   price: productData.docs[i]['price'].toString(),
              // )),
            ),
          );
        },
      );
}

// InkWell(
// onTap: () {
// Navigator.pushNamed(context, ProductDetailScreen.routeName,
// arguments: loadedProducts.items[i].id);
// },
// child: Card(
// color: const Color.fromRGBO(235, 235, 235, 1),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(loadedProducts.items[i].imageUrl,
// width: 90, height: 110, fit: BoxFit.fill),
// Padding(
// padding: EdgeInsets.only(left: 7),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(loadedProducts.items[i].title),
// Text(
// loadedProducts.items[i].price.toString(),
// style: const TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w700,
// color: kPrimaryColor),
// ),
// ],
// ),
// Container(
// child: IconButton(
// padding: EdgeInsets.zero,
// iconSize: 17,
// onPressed: () {
// setState(() {
// loadedProducts.items[i].isFavorite =
// !loadedProducts.items[i].isFavorite;
// });
// },
// icon: loadedProducts.items[i].isFavorite
// ? const Icon(
// FontAwesomeIcons.solidBookmark,
// color: kPrimaryColor)
// : Icon(
// FontAwesomeIcons.solidBookmark,
// color: Colors.grey.shade500,
// ),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
