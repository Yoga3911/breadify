import 'package:flutter/material.dart';
import 'package:project/app/views/product/add_product.dart';

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
  static const String addProduct = "/product/add";
  static const String cart = "/cart";
  static const String checkout = "/checkout";

  static final data = <String, WidgetBuilder>{
    introduction: (_) => const IntroductionPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(), 
    main: (_) => const MainPage(), 
    home: (_) => const HomePage(),
    feed: (_) => const FeedPage(),
    // history: (_) => const HistoryPage(),
    // ongoing: (_) => const OngoingPage(),
    favorite: (_) => const FavoritePage(),
    profile: (_) => const ProfilePage(),
    store: (_) => const StorePage(),
    addProduct: (_) => const AddProductPage(),
    product: (_) => const ProductPage(),
    cart: (_) => const CartPage(),
    checkout: (_) => const CheckoutPage(),
  };
}
