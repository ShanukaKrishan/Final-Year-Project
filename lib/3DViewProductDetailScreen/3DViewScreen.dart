import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imageview360/imageview360.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../cartScreen/cartScreen.dart';
import '../constants.dart';
import '../providers/cartProvider.dart';
import '../providers/productsProvider.dart';
import '../widgets/cartBadge.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class ARViewScreen extends StatefulWidget {
  static String routeName = "/ARDetailScreen";
  const ARViewScreen({Key? key}) : super(key: key);

  @override
  _ARViewScreenState createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  bool imagePrecached = false;
  bool autoRotate = true;
  List<AssetImage> imageList = List<AssetImage>.empty(growable: true);
  bool allowSwipeToRotate = true;
  int swipeSensitivity = 2;
  int rotationCount = 2;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 50);

  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => updateImageList(context));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductsProvider>(context).getArProductUsingId(productId);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              color: const Color.fromRGBO(236, 236, 236, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: ScreenUtil().setWidth(40),
                      child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const Text(
                      "PRODUCT DETAILS",
                      style:
                          TextStyle(fontFamily: kDMSerifDisplay, fontSize: 18),
                    ),
                    Consumer<CartProvider>(
                      builder: (_, cartData, ch) => CartBadge(
                          child: ch!,
                          value: cartData.itemCount == 0
                              ? 0.toString()
                              : cartData.itemCount.toString(),
                          color: kPrimaryColor),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: () {
                          pushNewScreen(context,
                              screen: CartScreen(), withNavBar: false);
                          // Navigator.pushNamed(
                          //   context,
                          //   CartScreen.routeName,
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (imagePrecached == true)
                      ? Container(
                          height: 300,
                          width: 300,
                          child: ImageView360(
                            key: UniqueKey(),
                            imageList: imageList,
                            autoRotate: true,
                            rotationCount: 2,
                            rotationDirection: RotationDirection.anticlockwise,
                            frameChangeDuration:
                                const Duration(milliseconds: 170),
                            swipeSensitivity: swipeSensitivity,
                            allowSwipeToRotate: allowSwipeToRotate,
                          ),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Color.fromRGBO(250, 250, 250, 1),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    loadedProduct.title,
                    style: kHeadingTitle,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "This watch is nine-millimeter thick steal, forty meters in diamater with 403L polished case that is in silver",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: kSourceSansPro,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$" + loadedProduct.price.toString(),
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontFamily: kDMSerifDisplay,
                        fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  loadedProduct.isFavorite =
                                      !loadedProduct.isFavorite;
                                });
                              },
                              icon: loadedProduct.isFavorite
                                  ? const Icon(FontAwesomeIcons.solidBookmark,
                                      color: kPrimaryColor)
                                  : const Icon(FontAwesomeIcons.solidBookmark),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: kPrimaryColor,
                            fixedSize: const Size(200, 50),
                          ),
                          onPressed: () {
                            cart.addItem(
                                loadedProduct.id.toString(),
                                loadedProduct.price.toDouble(),
                                loadedProduct.title,
                                loadedProduct.imagePath,
                                context);
                          },
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(fontFamily: kDMSerifDisplay),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              onPressed: () async {
                                await LaunchApp.openApp(
                                  androidPackageName:
                                      'com.DefaultCompany.test1',
                                );
                              },
                              icon: const Icon(FontAwesomeIcons.vrCardboard),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AppListItem(onClick: listClick, index: 1),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .getArProductUsingId(productId);
    switch (loadedProduct.id) {
      case '23':
        imageUpdate('assets/arWatch/');
        break;
      case '24':
        imageUpdate('assets/arWatch2/');
        break;
    }
  }

  void imageUpdate(String imageUrl) async {
    for (int i = 1; i <= 37; i++) {
      imageList.add(AssetImage(
        imageUrl + '$i.png',
      ));

      await precacheImage(AssetImage(imageUrl + '$i.png'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
