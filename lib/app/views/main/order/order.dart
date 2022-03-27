import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

//pemanggilan class
import '../../../models/orders_models.dart';

//utk konten tab bar History & On Going :
import 'package:project/app/views/main/order/widgets/history.dart';
import 'package:project/app/views/main/order/widgets/ongoing.dart';

final List<OrderContentHistory> orderscontenthistory = [
  OrderContentHistory(address: "address", status: "status", date: "date"),
  OrderContentHistory(address: "address", status: "status", date: "date"),
  OrderContentHistory(address: "address", status: "status", date: "date"),
];
final List<OrderContentOngoing> ordercontentongoing = [
  OrderContentOngoing(address: "address", status: "status", date: "date"),
  OrderContentOngoing(address: "address", status: "status", date: "date"),
  OrderContentOngoing(address: "address", status: "status", date: "date"),
];

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBar orderTabBar = const TabBar(
      indicatorColor: Colors.amber, //warna indikator tab bar
      labelColor: Colors.black, //warna tulisan di tab bar (History & On going)
      tabs: <Widget>[
        Tab(
          text: "History",
        ),
        Tab(
          text: "On Going",
        ),
      ],
    );
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffFFD635), //warna appbar
              title: const Text("Orders"),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  tooltip: "Cart",
                ),
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(orderTabBar.preferredSize.height),
                child: Container(
                  color: Colors.white, //warna tab bar
                  child: orderTabBar,
                ),
              ),
            ),
            body: TabBarView(children: <Widget>[
              //TABBAR ON GOING
              ListView.builder(
                  itemCount: orderscontenthistory.length,
                  itemBuilder: (context, index) =>
                      HistoryPage(index: index) //class utk Tab Bar On Going
                  ),
              //TABBAR HISTORY
              ListView.builder(
                  itemCount: ordercontentongoing.length,
                  itemBuilder: (context, index) =>
                      OngoingPage(index: index) //class utk Tab Bar On Going
                  ),
            ]),
          )),
    );
  }
}
