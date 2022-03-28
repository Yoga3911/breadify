import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/app/views/main/home/widgets/alert.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constant/collection.dart';
import '../../../view_model/user_prodvider.dart';
import '../../main/home/widgets/title.dart';
import '../../../views/main/home/widgets/category.dart';
import '../../../views/main/home/widgets/header.dart';
import '../../../views/main/home/widgets/product.dart';
import '../../../views/main/home/widgets/search.dart';
import '../../../constant/glow.dart';
import '../../../constant/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logoutDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LogOutDialog());
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    MyCollection.product.snapshots().listen((event) {
      inspect(event.docs.first["name"]);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    const String _blank =
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/user.png?alt=media&token=30e27068-d2ff-4dcb-b734-c818c49863fd";
    // final _categoryProvider = Provider.of<CategoryProvider>(context);
    final User _user = Provider.of<UserProvider>(context).getUser;

    return ScrollConfiguration(
      behavior: NoGlow(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: 1,
              onPressed: () {},
              icon: CircleAvatar(
                backgroundImage: NetworkImage(_user.photoURL ?? _blank),
              ),
            ),
            title: const AppBarTitle(),
            actions: [
              IconButton(
                onPressed: () {},
                splashRadius: 25,
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 30,
                    ),
                    Positioned(
                      left: 15,
                      top: 5,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: MyColor.red2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 25,
                icon: Image.asset("assets/icons/cart.png"),
              ),
              IconButton(
                onPressed: () => _logoutDialog(context),
                icon: const Icon(Icons.logout_rounded),
              )
            ],
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            heroTag: "home",
            backgroundColor: MyColor.red2,
            child: Image.asset(
              "assets/icons/message.png",
              color: Colors.white,
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            header: const WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              cacheExtent: 10000,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              children: const [
                Header(),
                SearchBar(),
                ProductCategory(),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Product(todayCategory: "Popular"),
                ),
                SizedBox(height: 20),
                // Container(
                //   child: (_categoryProvider.getCategory != "Today")
                //       ? Container(
                //           color: Colors.white,
                //           padding: const EdgeInsets.only(left: 10, right: 10),
                //           child: Column(
                //             children: const [],
                //           ),
                //         )
                //       : const HomeContent(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
