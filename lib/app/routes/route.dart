import 'package:flutter/material.dart';

import '../views/cart/cart.dart';
import '../views/cart/checkout.dart';
import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/main/favorite/favorite.dart';
import '../views/main/feed/feed.dart';
import '../views/main/main_page.dart';
import '../views/main/order/history.dart';
import '../views/main/order/ongoing.dart';
import '../views/profile/profile.dart';
import '../views/main/home/home.dart';
import '../views/introduction/introduction.dart';
import '../views/product/product.dart';
import '../views/product/store.dart';

class Routes {
  Routes._();

  static const String introduction = "/introduction";
  static const String login = "/login";
  static const String register = "/register";
  static const String main = "/main";
  static const String home = "/home";
  static const String feed = "/feed";
  static const String history = "/history";
  static const String ongoing = "/ongoing";
  static const String favorite = "/favorite";
  static const String profile = "/profile";
  static const String store = "/store";
  static const String product = "/product";
  static const String cart = "/cart";
  static const String checkout = "/checkout";

  static final data = <String, WidgetBuilder>{
    introduction: (context) => const IntroductionPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(), 
    main: (context) => const MainPage(), 
    home: (context) => const HomePage(),
    feed: (context) => const FeedPage(),
    history: (context) => const HistoryPage(),
    ongoing: (context) => const OngoingPage(),
    favorite: (context) => const FavoritePage(),
    profile: (context) => const ProfilePage(),
    store: (context) => const StorePage(),
    product: (context) => const ProductPage(),
    cart: (context) => const CartPage(),
    checkout: (context) => const CheckoutPage(),
  };
}
