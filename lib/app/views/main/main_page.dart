import 'package:flutter/material.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import 'feed/feed.dart';
import 'home/home.dart';
import 'favorite/favorite.dart';
import 'order/order.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _iconData = [
    {
      "path": "assets/icons/home.png",
      "label": "Home",
    },
    {
      "path": "assets/icons/compas.png",
      "label": "Feed",
    },
    {
      "path": "assets/icons/box.png",
      "label": "Orders",
    },
    {
      "path": "assets/icons/love.png",
      "label": "Favorite",
    },
  ];

  BottomNavigationBarItem btmNavbar(String label, String icon) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, scale: 1.5),
      activeIcon: Image.asset(
        icon,
        scale: 1.5,
        color: MyColor.yellow,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: MyColor.yellow,
        unselectedItemColor: MyColor.black,
        // showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: _iconData
            .map(
              (e) => btmNavbar(e["label"]!, e["path"]!),
            )
            .toList(),
      ),
      body: FutureBuilder<UserModel>(
        future: user.getByDocId(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          user.setUser = snapshot.data!;
          return IndexedStack(
            index: _selectedIndex,
            children: const [
              HomePage(),
              FeedPage(),
              OrderPage(),
              FavoritePage(),
            ],
          );
        },
      ),
    );
  }
}
