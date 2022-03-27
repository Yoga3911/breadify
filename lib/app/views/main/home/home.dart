import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project/app/services/facebook.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/main/home/widgets/content.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/route.dart';
import '../../../services/google.dart';
import '../../../view_model/category_provider.dart';
import '../../../views/main/home/widgets/category.dart';
import '../../../views/main/home/widgets/header.dart';
import '../../../views/main/home/widgets/product.dart';
import '../../../views/main/home/widgets/search.dart';
import '../../../constant/glow.dart';
import '../../../constant/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _logoutDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text(
          "Apakah kamu yakin ingin logout?",
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              switch (pref.getString("social")) {
                case "google":
                  await GoogleService.signOut();
                  break;
                case "facebook":
                  await FacebookService.signOut();
                  break;
              }
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            child: const Text("Yakin"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String _blank =
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/user.png?alt=media&token=30e27068-d2ff-4dcb-b734-c818c49863fd";
    final _categoryProvider = Provider.of<CategoryProvider>(context);
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
            title: Container(
              width: 170,
              height: 45,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: MyColor.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Rp 100.000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Click to see transaction history",
                    style: TextStyle(
                      color: MyColor.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
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
          body: ListView(
            children: [
              const Header(),
              const SearchBar(),
              const ProductCategory(),
              Container(
                child: (_categoryProvider.getCategory != "Today")
                    ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: const [
                          SizedBox(height: 10),
                          Product(todayCategory: "Category"),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                    : const HomeContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
