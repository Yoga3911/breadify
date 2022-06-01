import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
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

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final pref = await SharedPreferences.getInstance();
    final user = MyCollection.user.doc(pref.getString("id"));

    if (state == AppLifecycleState.resumed) {
      user.update({
        "isActive": true,
      });
    } else if (state == AppLifecycleState.paused) {
      user.update({
        "isActive": false,
      });
    }
    super.didChangeAppLifecycleState(state);
  }

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
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          for (Map<String, dynamic> e in _iconData)
            btmNavbar(e["label"]!, e["path"]!)
        ],
      ),
      body: FutureBuilder<void>(
        future: user.getByDocId(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

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
