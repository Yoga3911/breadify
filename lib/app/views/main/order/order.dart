import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

//pemanggilan class
import '../../../models/orders_models.dart';

//utk konten tab bar History & On Going :
import 'package:project/app/views/main/order/widgets/history.dart';
import 'package:project/app/views/main/order/widgets/ongoing.dart';

final List<OrderContentHistory> orderscontenthistory = [
  OrderContentHistory(
      address: "Jl. Mawar 2, No. 129",
      status: "Order successfuly delivered",
      date: "15 March 2022 01:20 PM"),
  OrderContentHistory(
      address: "Jl. Melati 1, No. 10",
      status: "Order successfuly delivered",
      date: "14 March 2022 12:20 PM"),
  OrderContentHistory(
      address: "Jl. Kenanga 12, No. 28",
      status: "Order successfuly delivered",
      date: "13 March 2022 05:00 PM"),
];
final List<OrderContentOngoing> ordercontentongoing = [
  OrderContentOngoing(
      address: "Jl. Mawar 1, No. 10",
      status: "Order delivered",
      date: "14 March 2022 12:20 PM"),
  OrderContentOngoing(
      address: "Jl. Permata Suci No. 90",
      status: "Order delivered",
      date: "14 March 2022 12:20 PM"),
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
            body: TabBarView(
              children: <Widget>[
              //TABBAR HISTORY
              ListView.builder(
                  itemCount: orderscontenthistory.length,
                  itemBuilder: (context, index) =>
                      HistoryPage(index: index) //class utk Tab Bar On Going
                  ),

              //TABBAR ON GOING
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
