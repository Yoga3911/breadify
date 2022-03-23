import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';

import 'feed/feed.dart';
import 'home/home.dart';
import 'favorite/favorite.dart';
import 'order/history.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onTap(int index) => setState(() => _selectedIndex = index);

  final List<Widget> _widgetData = [
    const HomePage(),
    const FeedPage(),
    const HistoryPage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: _onTap,
        selectedItemColor: MyColor.yellow,
        unselectedItemColor: MyColor.black,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/compas.png", scale: 1.5),
            activeIcon: Image.asset(
              "assets/icons/compas.png",
              scale: 1.5,
              color: MyColor.yellow,
            ),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/box.png", scale: 1.5),
            activeIcon: Image.asset(
              "assets/icons/box.png",
              scale: 1.5,
              color: MyColor.yellow,
            ),
            label: "Orders",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            activeIcon: Icon(Icons.favorite_outline_rounded),
            label: "Favorite",
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetData,
      ),
    );
  }
}
