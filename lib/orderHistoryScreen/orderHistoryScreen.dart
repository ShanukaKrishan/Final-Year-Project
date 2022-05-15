import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:watch_store/orderHistoryScreen/orderHistoryDetailScreen.dart';
import 'package:watch_store/providers/orderProvider.dart';

import 'package:provider/provider.dart';
import '../constants.dart';

class OrderHistoryScreen extends StatefulWidget {
  static String routeName = '/OrderHistoryScreen';
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<OrderProvider>(context, listen: false);
      await provider.getOrderDetailsFromFirebase();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                "ORDER  HISTORY",
                style: kTextAppBarTitle,
              ),
            ),
          ];
        },
        body: Consumer<OrderProvider>(
          builder: (context, provider, child) {
            if (provider.orderFetching) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: provider.orderHistory.length,
                itemBuilder: (ctx, i) {
                  //print(provider.orderHistory[0].products[0].);
                  return OrderCard(
                    status: provider.orderHistory[i].orderStatus,
                    orderId: provider.orderHistory[i].orderId,
                    orderDate: provider.orderHistory[i].orderDate,
                    totalPaid: provider.orderHistory[i].totalPaid,
                  );
                });
            // return ListView.builder(
            //     itemCount: provider.orderHistory.length,
            //     itemBuilder: (ctx, i) {
            //       return Column(
            //         children: [Text(provider.orderHistory[i].orderId)],
            //       );
            //     });
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderDate;
  final String orderId;
  final String totalPaid;
  final String status;

  const OrderCard(
      {Key? key,
      required this.orderDate,
      required this.orderId,
      required this.totalPaid,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: kPrimaryColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const Text(
                        "ORDER ID  ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        orderId,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Image.asset('assets/images/calendar1.png',
                      scale: 2, color: Colors.white),
                  const SizedBox(width: 7),
                  const Text(
                    "Ordered Date",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    orderDate,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Image.asset('assets/images/money.png',
                      alignment: Alignment.centerLeft,
                      scale: 2,
                      color: Colors.white),
                  const SizedBox(width: 7),
                  const Text(
                    "Total Amount",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    "\$$totalPaid",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: checkColor(), borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Image.asset('assets/images/sand.png',
                      alignment: Alignment.centerLeft,
                      scale: 2,
                      color: Colors.white),
                  const SizedBox(width: 7),
                  const Text(
                    "Status",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 42,
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    toBeginningOfSentenceCase(status).toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 3),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () => pushNewScreenWithRouteSettings(context,
                    screen: const OrderHistoryDetail(),
                    withNavBar: false,
                    settings: RouteSettings(arguments: orderId)),
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String checkImage() {
    switch (status.isNotEmpty ? status.toLowerCase() : '') {
      case 'pending':
        return 'assets/images/sand.png';
      case 'processing':
        return 'assets/images/box.png';
      case 'shipped':
        return 'assets/images/airplane.png';
      case 'delivered':
        return 'assets/images/delivery.png';
      case 'cancelled':
        return 'assets/images/cancel.png';
      default:
        return '';
    }
  }

  Color checkColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.blueAccent.withOpacity(0.3);
      case 'shipped':
        return Colors.purple.withOpacity(0.3);
      case 'delivered':
        return Colors.tealAccent.withOpacity(0.3);
      case 'processing':
        return Colors.amberAccent.withOpacity(0.3);
      case 'cancelled':
        return Colors.red.shade900.withOpacity(0.3);
      default:
        return Colors.black87.withOpacity(0.3);
    }
  }
}
