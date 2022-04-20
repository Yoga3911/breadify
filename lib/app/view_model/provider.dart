import 'package:project/app/view_model/cart_provider.dart';
import 'package:project/app/view_model/notif_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth_provider.dart';
import 'category_provider.dart';
import 'order_provider.dart';
import 'product_provider.dart';
import 'store_provider.dart';
import 'user_prodvider.dart';
import 'feed_provider.dart';

final List<SingleChildWidget> providerData = [
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => StoreProvider()),
  ChangeNotifierProvider(create: (_) => CartProvider()),
  ChangeNotifierProvider(create: (_) => FeedProvider()),
  ChangeNotifierProvider(create: (_) => OrderProvider()),
  ChangeNotifierProvider(create: (_) => NotifProvider()),
];
