import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/providers/addressProvider.dart';
import 'package:watch_store/widgets/OrderItemCard.dart';

import '../providers/orderProvider.dart';

class OrderHistoryDetail extends StatefulWidget {
  static String routeName = '/orderHistoryScreen';

  const OrderHistoryDetail({Key? key}) : super(key: key);

  @override
  State<OrderHistoryDetail> createState() => _OrderHistoryDetailState();
}

class _OrderHistoryDetailState extends State<OrderHistoryDetail> {
  var orderItem;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final String orderId =
          ModalRoute.of(context)!.settings.arguments as String;

      orderItem = Provider.of<OrderProvider>(context, listen: false)
          .getOrderUsingId(orderId)
          .orderStatus;

      // await provider.getFavorites();
    });
    checkStep();
    super.initState();
  }

  int _currentStep = 0;

  void checkStep() {
    //orderItem.toString().toLowerCase()
    switch ('shipped') {
      case 'pending':
        _currentStep = 0;
        break;
      case 'processing':
        _currentStep = 1;

        break;
      case 'shipped':
        _currentStep = 2;
        break;
      case 'delivered':
        _currentStep = 3;

        break;
    }
  }

  StepState checkState(int count) {
    switch (count) {
      case 0:
        if (_currentStep == 0) {
          return StepState.progress;
        }
        if (_currentStep >= 1) {
          return StepState.complete;
        } else {
          return StepState.none;
        }
      case 1:
        if (_currentStep == 1) {
          return StepState.progress;
        }
        if (_currentStep >= 2) {
          return StepState.complete;
        } else {
          return StepState.none;
        }
      case 2:
        if (_currentStep == 2) {
          return StepState.progress;
        }
        if (_currentStep >= 2) {
          return StepState.complete;
        } else {
          return StepState.none;
        }
      case 3:
        if (_currentStep == 3) {
          return StepState.complete;
        }
        if (_currentStep >= 3) {
          return StepState.complete;
        } else {
          return StepState.none;
        }
    }
    return StepState.disabled;
  }

  @override
  Widget build(BuildContext context) {
    final String orderId = ModalRoute.of(context)!.settings.arguments as String;
    print(orderId);
    final orderItem = Provider.of<OrderProvider>(context, listen: false)
        .getOrderUsingId(orderId);

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final addressProvider = Provider.of<UserAddress>(context);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Order History Detail",
                style: kTextAppBarTitle,
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  Text(
                    'Order number  ' + orderItem.orderId,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  orderItem.orderStatus.toLowerCase() == 'canceled'
                      ? Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        LottieBuilder.asset(
                                          'assets/images/delivery-cancellation.json',
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(
                                          "Your Order was cancelled ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        )
                      : Stepper(
                          currentStep: _currentStep,
                          physics: NeverScrollableScrollPhysics(),
                          controlsBuilder:
                              (BuildContext context, ControlsDetails controls) {
                            return Container();
                          },
                          steps: [
                            Step(
                                content: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      builtStepText('Order placed on ' +
                                          orderItem.orderDate),
                                      builtStepText(
                                          "Waiting till merchant accept order."),
                                    ],
                                  ),
                                ),
                                title: Text("Pending"),
                                isActive: _currentStep >= 0,
                                state: checkState(0)),
                            Step(
                              title: const Text("Processing"),
                              state: checkState(1),
                              content: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    builtStepText(
                                        'Order is being packed for shipment.'),
                                    const SizedBox(height: 2),
                                    builtStepText("Protection first ;)"),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 1,
                            ),
                            Step(
                              state: checkState(2),
                              content: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    builtStepText(
                                        'Order handed over to delivery team.'),
                                    builtStepText(
                                        "Estimated arrival time 7-10 business days."),
                                  ],
                                ),
                              ),
                              title: Text("Shipped"),
                              isActive: _currentStep >= 2,
                            ),
                            Step(
                              content: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    builtStepText(
                                        'Successfully handed package over'),
                                  ],
                                ),
                              ),
                              state: checkState(3),
                              title: Text("Devlivered"),
                              isActive: _currentStep >= 3,
                            ),
                          ],
                        ),
                  //
                  // Divider(
                  //   color: Colors.grey.shade600,
                  // ),
                  // // buildTile('Total amount',),
                  // const SizedBox(height: 10),
                  //
                  // buildTile('Shipping', 'Free'),
                  // const SizedBox(height: 10),
                  // buildTile(
                  //     'Order status',
                  //     toBeginningOfSentenceCase(orderItem.orderStatus)
                  //         .toString()),
                  // const SizedBox(height: 10),
                  // buildTile('Total paid', orderItem.totalPaid),
                  // const SizedBox(height: 10),
                  // buildTile('Payment method', 'Credit'),
                  // const SizedBox(height: 10),
                  // Divider(
                  //   color: Colors.grey.shade600,
                  // ),
                  // const Text(
                  //   "Shipping Address",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: kPrimaryColor,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   orderItem.addressOne,
                  // ),
                  // SizedBox(height: 5),
                  // Text(
                  //   orderItem.addressTwo,
                  // ),
                  // SizedBox(height: 5),
                  // Text(
                  //   orderItem.zipCode,
                  // ),
                  // Text(
                  //   orderItem.country,
                  // ),
                  // Divider(
                  //   color: Colors.grey.shade600,
                  // ),
                  SizedBox(height: 10),
                  orderItem.orderStatus.toLowerCase() == 'canceled'
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: kPrimaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "Email",
                                  style: TextStyle(fontFamily: kDMSerifDisplay),
                                ),

                                SizedBox(width: 10),
                                Text(':  ' + orderItem.email,
                                    textAlign: TextAlign.start),
                                // Container(
                                //   width: 100,
                                //   alignment: Alignment.centerLeft,
                                //   child: Text(
                                //     orderItem.email,
                                //     style: const TextStyle(fontFamily: kDMSerifDisplay),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: kPrimaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: 3),
                                SizedBox(width: 10),
                                Text(
                                  "Phone",
                                  style: TextStyle(fontFamily: kDMSerifDisplay),
                                ),
                                Text('   :  ' + orderItem.phone,
                                    textAlign: TextAlign.start),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),

                  const Text(
                    "Ordered Items",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: orderProvider.orderHistory[0].products.length,
                      itemBuilder: (ctx, index) {
                        print(orderProvider.orderHistory[0].products.length);
                        return Column(
                          children: [
                            OrderItemCard(
                                id: orderProvider.orderHistory[0]
                                    .products[index]['productId'],
                                imageUrl: orderProvider.orderHistory[0]
                                    .products[index]['imageUrl'],
                                price: orderProvider.orderHistory[0]
                                    .products[index]['itemPrice']
                                    .toString(),
                                productId: orderProvider.orderHistory[0]
                                    .products[index]['productId'],
                                quantity: orderProvider.orderHistory[0]
                                    .products[index]['quantity'],
                                title: orderProvider.orderHistory[0]
                                    .products[index]['productTitle']),
                            SizedBox(height: 6),
                          ],
                        );
                      }),
                  // SizedBox(
                  //   height: 200,
                  //   child: ListView(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     children: orderItem.products
                  //         .map((e) => Container(
                  //             height: 300,
                  //             width: 300,
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     SizedBox(
                  //                       height: 140,
                  //                       width: 120,
                  //                       child: Image.asset(
                  //                         e.imageUrl,
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: ScreenUtil().setWidth(10),
                  //                     ),
                  //                     Column(
                  //                       children: [
                  //                         Text(
                  //                           e.title,
                  //                         ),
                  //                         Text(e.quantity.toString())
                  //                       ],
                  //                     )
                  //                   ],
                  //                 )
                  //               ],
                  //             )))
                  //         .toList(),
                  //   ),
                  // ),
                ],
              )),
        ),
      ),
    );
  }

  Text builtStepText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade400,
      ),
    );
  }

  Row buildTile(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, textAlign: TextAlign.start),
        Container(
          width: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(fontFamily: kDMSerifDisplay),
          ),
        ),
      ],
    );
  }
}
//
// List<Step> getSteps() {
//   return [
//     Step(
//       title: Text("Pending"),
//       content: Container(),
//       isActive: >= 0
//     ),
//     Step(title: Text("Processing"), content: Container()),
//     Step(title: Text("Shipped"), content: Container()),
//     Step(title: Text("Delivered"), content: Container()),
//   ];
// }
