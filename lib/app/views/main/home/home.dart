import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../view_model/category_provider.dart';
import '../../../view_model/user_prodvider.dart';
import '../home/widgets/alert.dart';
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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    final product = Provider.of<ProductProvider>(context, listen: false);
    final category = Provider.of<CategoryProvider>(context, listen: false);
    await product.getByCategory("Popular");
    product.setStatus = state.loading;
    category.setCategory = "Popular";
    if (product.getDataFilter.isNotEmpty) {
      product.setStatus = state.done;
    } else if (product.getDataFilter.isEmpty) {
      product.setStatus = state.empty;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void didChangeDependencies() async {
    final product = Provider.of<ProductProvider>(context, listen: false);
    await product.getByCategory("Popular");
    if (product.getDataFilter.isNotEmpty) {
      product.setStatus = state.done;
    } else if (product.getDataFilter.isEmpty) {
      product.setStatus = state.empty;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: 1,
              onPressed: () => Navigator.pushNamed(context, Routes.profile),
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: user.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const AppBarTitle(),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notif);
                },
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
                onPressed: () => Navigator.pushNamed(context, Routes.cart),
                splashRadius: 25,
                icon: Image.asset("assets/icons/cart.png"),
              ),
              IconButton(
                onPressed: () => showDialog(
                    context: context, builder: (_) => const LogOutDialog()),
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
              children: const [
                Header(),
                SearchBar(),
                ProductCategory(),
                Product(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
