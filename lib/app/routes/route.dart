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
import '../views/product/discount_product.dart';
import '../views/product/hot_product.dart';
import '../views/product/popular_product.dart';
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
  static const String popularProduct = "/product/popular";
  static const String hotProduct = "/product/hot";
  static const String discountProduct = "/product/discount";
  static const String cart = "/cart";
  static const String checkout = "/checkout";

  static final data = <String, WidgetBuilder>{
    introduction: (_) => const IntroductionPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(), 
    main: (_) => const MainPage(), 
    home: (_) => const HomePage(),
    feed: (_) => const FeedPage(),
    history: (_) => const HistoryPage(),
    ongoing: (_) => const OngoingPage(),
    favorite: (_) => const FavoritePage(),
    profile: (_) => const ProfilePage(),
    store: (_) => const StorePage(),
    product: (_) => const ProductPage(),
    popularProduct: (_) => const PopularProductPage(),
    hotProduct: (_) => const HotProductPage(),
    discountProduct: (_) => const DiscountProductPage(),
    cart: (_) => const CartPage(),
    checkout: (_) => const CheckoutPage(),
  };
}
